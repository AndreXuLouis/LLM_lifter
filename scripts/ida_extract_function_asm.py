import idaapi
import idautils
import idc
import ida_frame
import ida_funcs
import ida_typeinf
import ida_name
import ida_bytes
import ida_ua
import ida_entry
import ida_segment
import ida_xref

from typing import List, Tuple, Dict
import sys
import os
import struct

from ida_utils import *
from utils import get_string_type
from get_function_name import extract_non_runtime_function_names
from IDAProDisassembly import *
from LLVMDataType import *
from Analysis import rename_dummy_symbols, infer_global_var_type


def get_func_frame_info(func_ea):
    local_vars = []
    frame_id = idc.get_frame_id(func_ea)
    frame_local_var_size = idc.get_frame_lvar_size(func_ea)
    frame_arg_size = idc.get_frame_args_size(func_ea)
    # 局部变量
    if frame_id != 0xffffffffffffffff:
        print(f"arg size of func {idc.get_func_name(func_ea)} is {frame_arg_size}")
        for offset, name, size in idautils.StructMembers(frame_id):
            if name == "__return_address":
                continue
            if name == "__saved_registers":
                continue
            var_size_str = f"qword ptr" if size == 8 else f"dword ptr" if size == 4 else f"word ptr" if size == 2 else f"byte ptr"
            print(f"{name} = {var_size_str} {hex(offset - frame_local_var_size)}h")
            # output_file.write(f"{name} = {var_size_str} {hex(offset - frame_local_var_size)}h\n")
            local_vars.append((name, size, offset - frame_local_var_size))
    return local_vars

def disassemble_function(func_ea, substitutions = None):
    # -> Tuple[List[IDAProFunction], List[IDAProConstant], List[str], List[str]]:
    """
    反汇编指定函数
    """
    func_start = func_ea
    func_end = idc.find_func_end(func_start)
    func_name = idc.get_func_name(func_ea)
    print(f"Disassembling {func_name} proc")

    func = IDAProFunction(func_name)
    constants = []
    global_vars = []
    extern_vars = []

    # 局部变量
    local_vars = get_func_frame_info(func_ea)
    for name, size, offset in local_vars:
        func.add_localvar(name, size, offset)

    # 交叉引用的类型 
    #0 = 'Data_Unknown'
    #1 = 'Data_Offset'
    #2 = 'Data_Write'
    #3 = 'Data_Read'
    #4 = 'Data_Text'
    #5 = 'Data_Informational'
    #16 = 'Code_Far_Call'
    #17 = 'Code_Near_Call'
    #18 = 'Code_Far_Jump'
    #19 = 'Code_Near_Jump'
    #20 = 'Code_User'
    #21 = 'Ordinary_Flow'

    # 遍历函数中的每一条指令
    for head in idautils.Heads(func_start, func_end):
        disasm_line = idc.generate_disasm_line(head, 0)
        disasm_line = disasm_line.split(';')[0] # delete comment
        
        # insn = idautils.DecodeInstruction(head)
        # print(f"insn = {insn}")

        # for op in insn.ops:
        #     print(f"size = {ida_ua.get_dtype_size(op.dtype)}")
        #     print(f"is_float = {ida_ua.is_floating_dtype(op.dtype)}")

        if not disasm_line:
            print(f"error when disassembling instructions at {hex(head)}")
            sys.exit(1)
        # disasm_line = replace_imm_with_decimal(head, disasm_line)

        for xref in idautils.XrefsFrom(head, ida_xref.XREF_ALL):
            ref_to = xref.to
            ref_type = xref.type
            # print(f"get_type = {idc.get_type(ref_to)}")
            print(f"Reference from {hex(head)} to {hex(ref_to)} Type: {idautils.XrefTypeName(ref_type)}")
            # 首先将dummy name重命名
            # name = idc.get_name(ref_to)
            # if name in substitutions.keys():
            #     name_with_offset = substitutions[name]
            #     disasm_line = disasm_line.replace(name, name_with_offset)
            #     # 然后将对应的全局数据加入到globals中
            #     # nearest_name, nearest_name_addr = get_nearest_name(ref_to)
            #     # assert(not is_dummy_name(nearest_name_addr))
            #     # assert(idc.get_name(nearest_name_addr) == nearest_name)
            #     nearest_name = nearest_name_for_dummy_name[name]
            #     global_vars[nearest_name] = IDAProGlobalVar(nearest_name, type_analysis[nearest_name], None)

            if ref_type == 21: # 21: Ordinary_Flow
                continue

            # 处理call指令
            # print(f"idc.is_code(ref_to) = {idc.is_code(ref_to)}")
            if ref_type == 17: # 17: Code_Near_Call
                # call指令去掉前导.
                operand = idc.get_operand_value(head, 0)
                print(f"operand = {hex(operand)}")
                call_func_name = idc.get_func_name(operand)
                print(f"func_name is {call_func_name}")
                if call_func_name.startswith('.'):
                    disasm_line = f"call    {call_func_name[1:]}"
            
            if ref_type == 19: # 17: Code_Near_Jump
                # call指令去掉前导.
                operand = idc.get_operand_value(head, 0)
                print(f"operand = {hex(operand)}")
                call_func_name = idc.get_func_name(operand)
                print(f"func_name is {call_func_name}")
                if call_func_name.startswith('.'):
                    disasm_line = f"jmp    {call_func_name[1:]}"
            
            # if ref_type == 19 and is_func_start(ref_to): # 19: Code_Near_Jmp
            #     # jmp指令去掉前导.
            #     operand = idc.get_operand_value(head, 0)
            #     print(f"operand = {hex(operand)}")
            #     call_func_name = idc.get_func_name(operand)
            #     print(f"func_name is {call_func_name}")
            #     if call_func_name.startswith('.'):
            #         disasm_line = f"call    {call_func_name[1:]}"
            
            # 处理代码
            if ref_type == 1 and is_func_start(ref_to): # #1 = 'Data_Offset' 函数指针
                disasm_line += f" ; <func>{idc.get_name(ref_to)}</func>"

            # 处理只读数据引用
            # @todo: 只支持只读数据段的字符串与浮点立即数
            if in_read_only_section(ref_to):
                if is_fp_imm(ref_to, head):
                    # 处理浮点立即数：以注释形式显示
                    # movss      xmm0, cs:dword_6248
                    # => movss      xmm0, cs:dword_6248 ; 0x358637BD00000000
                    data_size = get_data_size(ref_to)
                    formatted_fp_imm = format_fp_imm(get_data_content(ref_to, data_size))
                    disasm_line += f"; {formatted_fp_imm}"
                elif is_strlit(ref_to):
                    # 处理字符串：作为全局常量显示
                    full_string = get_full_string(ref_to)
                    if not full_string:
                        print(f"decode string at {hex(ref_to)} failed")
                        continue
                    constants.append(IDAProStringConstant(idc.get_name(ref_to), full_string))
                else:
                    print(f"read-only section: global var {idc.get_name(ref_to)} at {hex(ref_to)}")
                    # print(f"Unsupported data type at address {hex(ref_to)}")
                    global_vars.append((ref_to, idc.get_name(ref_to)))
                continue
            
            # 处理外部数据引用
            is_extern, sym_name_elf = is_external_symbol(idc.ARGV[1], ref_to)
            if is_extern:
                print(f"data at address {hex(ref_to)} is external symbol")
                # 可能存在同名的情况
                sym_name = idc.get_name(ref_to)
                if sym_name != sym_name_elf:
                    print(f"Error for IDA analysis for symbol name at address {hex(ref_to)}, IDA: {sym_name}, ELF: {sym_name_elf}")
                    # 如果ida分析的结果不在.dynsym中，说明分析错了，直接用从ELF分析出的结果覆盖之
                    disasm_line = disasm_line.replace(f"ds:{sym_name}", f"ds:{sym_name_elf}")
                    sym_name = sym_name_elf
                # extern_vars.append(IDAProExternVar(sym_name, LLVMUnknown()))
                extern_vars.append(IDAProExternVar(sym_name, LLVMUnknown()))
                continue

            # 处理全局数据引用
            # @todo: 目前只支持整数类型
            if in_non_exec_section(ref_to):
                print(f"global var {idc.get_name(ref_to)} at {hex(ref_to)}")
                if has_non_dummy_name(ref_to):
                    global_vars.append((ref_to, idc.get_name(ref_to)))
                else: # 做数组哑名替换
                    name = idc.get_name(ref_to)
                    if name in substitutions.keys():
                        name_with_offset = substitutions[name]
                        disasm_line = disasm_line.replace(name, name_with_offset)
            # data_size = get_data_size(ref_to)
            # full_data = get_data_content(ref_to, data_size)
            

        #     # if ref_type == 1:  # 0x1: Data_Offset, ptr
        #     #     # 处理字符串引用
        #     #     if idc.is_code(idc.get_full_flags(ref_to)):
        #     #         idc.set_cmt(head, f"'{idc.get_name(ref_to)}' is a function", 0)
        #     #         disasm_line = idc.generate_disasm_line(head, 0)
        #     #     if not idc.is_strlit(idc.get_full_flags(ref_to)):
        #     #         continue
        #     #     # print(f"full_flags = {is_strlit(get_full_flags(ref.to))}")
        #     #     full_string = get_full_string(ref_to)
        #     #     if not full_string:
        #     #         print(f"decode string at {hex(ref_to)} failed")
        #     #         continue
        #     #     print("full_string: %s" %(repr(full_string)))
        #     #     print("len: %d" %(len(full_string)))
        #     #     print("last char: %d" %(ord(full_string[len(full_string)-1])))
        #     #     # 为该指令添加注释，显示完整字符串
        #     #     string_type = get_string_type(full_string)
        #     #     # if string_type:
        #     #     #     idc.set_cmt(head, f" <string>{repr(full_string)}</string> <type>{string_type}</type>", 0)
        #     #     #     disasm_line = idc.generate_disasm_line(head, 0)
        #     #     if string_type:
        #     #         constants.append(IDAProConstant(idc.get_name(ref_to), LLVMString(full_string), full_string))
        #     #     # disasm_line += f" ; {full_string}"

        #     if ref_type == 1: # Data offset
        #         pass
        #     elif ref_type == 3 or ref_type == 2: # 0x3: Data_Read 2: Data_Write
        #         # is external variable
        #         # print(f"name = {ida_name.get_ea_name(ref_to)}")
        #         # print(f"name = {ida_name.is_weak_name(ref_to)}")
        #         # if is_extern_var(ref_to):
        #         #     op_size = get_data_size(ref_to)
        #         print(hex(idc.get_full_flags(ref_to)))
        #         print(f"name = {idc.get_name(ref_to)}")

        #         # 处理外部引用的变量
        #         is_extern, sym_name_elf = is_external_symbol(idc.ARGV[1], ref_to)
        #         if is_extern:
        #             print(f"data at address {hex(ref_to)} is external symbol")
        #             # idc.set_cmt(head, f" <extern data>{sym_name_elf}</extern data>", 0)
        #             # disasm_line = idc.generate_disasm_line(head, 0)
        #             # 可能存在同名的情况
        #             sym_name = ida_name.get_ea_name(ref_to)
        #             if sym_name != sym_name_elf:
        #                 print(f"Error for IDA analysis for symbol name at address {hex(ref_to)}, IDA: {sym_name}, ELF: {sym_name_elf}")
        #                 # 如果ida分析的结果不在.dynsym中，说明分析错了，直接用从ELF分析出的结果覆盖之
        #                 disasm_line = disasm_line.replace(f"ds:{sym_name}", f"ds:{sym_name_elf}")
        #                 sym_name = sym_name_elf
        #             extern_vars.append(IDAProExternVar(sym_name, LLVMUnknown()))
        #             continue
        #         op_size = get_data_size(ref_to)
        #         print(f"op_size = {op_size}")
        #         if op_size == None:
        #             continue
        #         # 处理立即数
        #         # if idc.get_full_flags(ref_to) & idc.FF_IVL:
        #         #     name = idc.get_name(ref_to)
        #         #     print(name)
        #         #     full_data = get_hex_data(ref_to, op_size)
        #         #     # 将反汇编代码中的常量操作数替换成十六进制表示
        #         #     output = []
        #         #     for part in disasm_line.split(","):
        #         #         if name in part:
        #         #             if is_float_point_insn(head):
        #         #                 output.append(" 0x" + f"{full_data:<016x}".upper())
        #         #             else:
        #         #                 output.append(f"{full_data}")
        #         #         else:
        #         #             output.append(part)
        #         #     disasm_line = ",".join(output)
        #         #     continue
        #         # 处理全局变量
        #         # 处理浮点全局变量
        #         if is_float_point_insn(head):
        #             if op_size == 4:
        #                 full_data = get_hex_data(ref_to, 4)
        #                 # full_data = idc.GetFloat(ref_to)
        #             elif op_size == 8:
        #                 full_data = get_hex_data(ref_to, 8)
        #                 # full_data = idc.GetDouble(ref_to)
        #             else:
        #                 print(f"Unsupported floating point data at address {hex(ref_to)}")
        #                 continue
        #             if full_data == None:
        #                 print(f"Failed to read floating point data from address {hex(ref_to)}")
        #                 continue

        #             print(f"full_data: {full_data}")
        #             if not is_dummy_name(ref_to) and \
        #                 type_analysis[idc.get_name(ref_to)].dtype == LLVMDataTypeEnum.Float and\
        #                 type_analysis[idc.get_name(ref_to)].size == op_size:
        #                 global_vars[idc.get_name(ref_to)] = IDAProGlobalVar(idc.get_name(ref_to), LLVMFloat(op_size), full_data)
        #             # disasm_line = idc.generate_disasm_line(head, 0)
        #         else: # is integer
        #             full_data = get_hex_data(ref_to, op_size)
        #             if full_data == None:
        #                 print(f"Failed to read integer data from address {hex(ref_to)}")
        #                 continue
        #             print(f"full_data: {full_data}")
        #             # idc.set_cmt(head, f" <data>i{op_size * 8} {full_data}</data>", 0)
        #             # disasm_line = idc.generate_disasm_line(head, 0)
        #             # @todo
        #             if not is_dummy_name(ref_to) and \
        #                 type_analysis[idc.get_name(ref_to)].dtype == LLVMDataTypeEnum.Int and\
        #                 type_analysis[idc.get_name(ref_to)].size == op_size:
        #                 global_vars[idc.get_name(ref_to)] = IDAProGlobalVar(idc.get_name(ref_to), LLVMInteger(op_size), full_data)
        #     elif ref_type == 17: # 17: Code_Near_Call
        #         # call指令去掉前导.
        #         operand = idc.get_operand_value(head, 0)
        #         print(f"operand = {hex(operand)}")
        #         call_func_name = idc.get_func_name(operand)
        #         print(f"func_name is {call_func_name}")
        #         if call_func_name.startswith('.'):
        #             disasm_line = f"call    {call_func_name[1:]}"

        # insn_label = None
        # # 为target附上label
        # if is_target_of_jmp(head):
        #     insn_label = IDAProLabel(f"loc_{hex(head)[2:].upper()}", head)
        #     # disasm_line = f"loc_{hex(head)[2:].upper()}:\n{disasm_line}" 
        # # 为fallthru附上label            
        # if is_fallthru_of_jcc(head) and not is_jmp(head):
        #     insn_label = IDAProLabel(f"loc_{hex(head)[2:].upper()}", head)

        # 处理跳转
        insn_label = None
        # 为target附上label
        if is_target_of_jmp(head):
            insn_label = IDAProLabel(f"loc_{hex(head)[2:].upper()}", head)
            # disasm_line = f"loc_{hex(head)[2:].upper()}:\n{disasm_line}" 
        # 为fallthru附上label            
        if is_fallthru_of_jcc(head) and not is_jmp(head):
            insn_label = IDAProLabel(f"loc_{hex(head)[2:].upper()}", head)
        func.add_insn(disasm_line, insn_label)

        print(f"Disassembled {hex(head)}: {disasm_line}")

    print(f"\n{func_name} endp")
    return func, constants, global_vars, extern_vars

def main():
    if len(idc.ARGV) != 3:
        print("Usage: ida_extract_function_asm.py /path/to/binary /path/to/output_asm")
        sys.exit(1)

    elf_file_path = idc.ARGV[1]
    output_asm_path = idc.ARGV[2]

    lift_funcs_file = f"{os.path.dirname(__file__)}/lift_funcs.txt"
    with open(lift_funcs_file, "r") as f:
        lift_funcs = f.read().splitlines()

    # non_runtime_function_names = extract_non_runtime_function_names(elf_file_path)
    # print(f"Functions need to be lifted: {non_runtime_function_names}")

    # all_funcs = get_all_funcs()
    all_funcs = extract_non_runtime_function_names(elf_file_path)
    if not lift_funcs: 
        # 如果lift_funcs没有指定需要提升的函数，则默认提升所有函数
        lift_funcs = all_funcs
    else:
        # 检查提升的函数是否在候选函数列表中
        pass
        # for lift_func in lift_funcs: 
        #     if lift_func not in all_funcs:
        #         print(f"function {lift_func} not in program {elf_file_path}!")
        #         sys.exit(1)

    print(lift_funcs)

    print("Analyzing dummy name =============================")
    substitutions, _= rename_dummy_symbols()
    print("substitutions for dummy_symbols is as follows:")
    for dummy_name, new_name in substitutions.items():
        print(f"{dummy_name}: {new_name}")

    print("Analyzing global variable ==========================")
    type_analysis = infer_global_var_type()
    print("Analysis Results:")
    for name, (inferred_type, init_data) in type_analysis.items():
        print(f"{name}: {inferred_type} {init_data}")    

    disassembly_output = IDAProDisassembly()
    for func_ea in idautils.Functions():
        func_name = idc.get_func_name(func_ea)
        if func_name not in lift_funcs:
            continue
        print("=======================================")
        print(f"Disassembling function: {func_name} at {hex(func_ea)}")
        func, constants, global_vars, extern_vars = \
            disassemble_function(func_ea, 
                                 substitutions=substitutions
                                )
        disassembly_output.add_function(func)
        disassembly_output.add_constants(constants)
        for gv_ea, gv_name in global_vars:
            type = LLVMUnknown()
            init_data = None
            if gv_name in type_analysis.keys():
                type, init_data = type_analysis[gv_name]
            disassembly_output.add_globalvar(gv_name, type, init_data)
            # 加入指针数组指向的对象
            constants = []
            print(f"name = {gv_name}, init_data = {init_data}")
            if init_data and len(init_data) >= 1 and isinstance(init_data[0], tuple):
                for ea, name in init_data:
                    if is_string_symbol(ea):
                        full_string = get_full_string(ea)
                        if not full_string:
                            print(f"decode string at {hex(ea)} failed")
                            continue
                        constants.append(IDAProStringConstant(idc.get_name(ea), full_string))
            disassembly_output.add_constants(constants)
                                       
        # disassembly_output.add_globalvars(global_vars)
        disassembly_output.add_externvars(extern_vars)

    with open(output_asm_path, "w") as output_file:
        disassembly_output.dump(output_file)

def dump_func_flag():
    for func_ea in idautils.Functions():
        print(f"func {idc.get_func_name(func_ea)} flags: {hex(idc.get_func_flags(func_ea))}")



def dump_xref(data_segm_name):
    data_segm = ida_segment.get_segm_by_name(data_segm_name)
    print(f"start addr of segment {data_segm_name}: {hex(data_segm.start_ea)}")
    print(f"end addr of segment {data_segm_name}: {hex(data_segm.end_ea)}")
    print(f"dump heads in segment {data_segm_name}:")
    for head in idautils.Heads(data_segm.start_ea, data_segm.end_ea):
        dump_data_xref(head)

    print(f"dump names in segment {data_segm_name}:")
    for ea, name in idautils.Names():
        if data_segm.start_ea <= ea < data_segm.end_ea:
            print(f"{hex(ea)}: {name}")
            ff = idc.get_full_flags(ea)
            state = "code" if idaapi.is_code(ff) \
                    else "data" if idaapi.is_data(ff) \
                    else "tail" if idaapi.is_tail(ff) \
                    else "unknown" if idaapi.is_unknown(ff) \
                    else "nononono"
            print(f"state of byte at {hex(ea)}: {state}")


        

# 等待IDA分析完毕
idaapi.auto_wait()

# 调用主函数
main()
dump_xref(".data")
# dump_func_flag()

# 退出 IDA
idaapi.qexit(0)

