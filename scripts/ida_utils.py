from elftools.elf.elffile import ELFFile
from elftools.elf.constants import SHN_INDICES
from enum import Enum, auto
from typing import List
from IDAProDisassembly import *
import sys
import re
import struct
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


class InsnType(Enum):
    InsnInt = auto()
    InsnFloat = auto()

    def is_int(self):
        return self == InsnType.InsnInt
    def is_float(self):
        return self == InsnType.InsnFloat

def is_external_symbol(elf_path, address):
    """
    检查地址是否属于外部模块定义的符号。
    
    :param elf_path: ELF 文件路径
    :param address: 要检查的地址（整数）
    :return: (bool, symbol_name or None) 
             True 和符号名如果是外部符号，否则 False 和 None
    """
    try:
        with open(elf_path, 'rb') as f:
            elffile = ELFFile(f)

            # 获取动态符号表或普通符号表
            symtab = elffile.get_section_by_name('.dynsym')
            if not symtab:
                print("未找到符号表")
                return False, None

            for symbol in symtab.iter_symbols():
                # print(symbol.name)
                # 过滤外部符号（符号绑定类型为 STB_GLOBAL 或 SHN_UNDEF 表示外部模块）
                if symbol['st_shndx'] == SHN_INDICES.SHN_UNDEF or symbol.entry['st_info']['bind'] == 'STB_GLOBAL':
                    symbol_address = symbol['st_value']
                    symbol_size = symbol['st_size']

                    # print(hex(address))
                    # print(hex(symbol_address))
                    # print(hex(symbol_size))
                    if symbol_address <= address and address < symbol_address + symbol_size:
                        return True, symbol.name

        return False, None

    except Exception as e:
        print(f"处理文件时出错: {e}")
        return False, None

def is_unknown(ea):
    return idc.is_unknown(idc.get_full_flags(ea))

def is_code(ea):
    return idc.is_code(idc.get_full_flags(ea))

def is_data(ea):
    return idc.is_data(idc.get_full_flags(ea))

def is_padding(ea):
    return idaapi.is_align(idc.get_full_flags(ea))

def is_double(ea):
    return idaapi.is_double(idc.get_full_flags(ea))

def has_non_dummy_name(ea):
    return has_any_name(ea) and not has_dummy_name(ea) and not has_auto_name(ea)

def has_auto_name(ea):
    return idaapi.has_auto_name(idc.get_full_flags(ea))

def has_any_name(ea):
    return idaapi.has_any_name(idc.get_full_flags(ea))

def has_dummy_name(ea):
    return idaapi.has_dummy_name(idc.get_full_flags(ea))

def is_string_symbol(ea):
    return idc.is_strlit(idc.get_full_flags(ea))  # Check if the symbol is a string literal

def is_immediate(ea):
    # return idc.get_full_flags(ea) & idc.FF_IVL
    ff = idc.get_full_flags(ea)
    return idc.is_data(ff) and idaapi.has_dummy_name(ff) and in_read_only_section(ea)

def get_ref_type(ref):
    """
    获取引用的类型。
    """
    ref_type = ref.type
    return ref_type

def get_full_string(ea):
    """
    获取指定地址的完整字符串，不受显示长度限制
    """
    # 获取字符串的内容
    string_length = idc.get_strlit_contents(ea, -1)
    if string_length:
        return string_length.decode('utf-8', errors='ignore')
    return None

def get_operand_size(insn_ea, data_ea):
    # # for op_index in range(2):  # 最多支持两个操作数
    # #     if idc.get_operand_type(ea, op_index) in [idc.o_mem, idc.o_displ, idc.o_phrase]:
    # #         # 获取操作数的位宽（按 IDA 的格式）
    # #         print(f"ea = {hex(ea)}")
    # #         op_width = idc.get_item_size(ea)
    # #         if op_width:
    # #             return op_width  # 返回操作数的字节大小
    # # return None
    # if idc.print_insn_mnem(ea) == 'movsd':
    #     return 8
    # elif idc.print_insn_mnem(ea) == 'movss':
    #     return 4
    # else:
    #     return None
    insn = idautils.DecodeInstruction(insn_ea)
    for n, op in enumerate(insn.ops):
        if idc.get_operand_value(insn_ea, n) == data_ea:
            size = ida_ua.get_dtype_size(op.dtype)
            return size
    return None

def get_data_size(ea):
    assert(idc.is_data(idc.get_full_flags(ea)))
    return idc.get_item_size(ea)
    # full_flags = idc.get_full_flags(ea)
    # if idc.is_qword(full_flags):
    #     return 8
    # elif idc.is_dword(full_flags):
    #     return 4
    # elif idc.is_word(full_flags):
    #     return 2
    # elif idc.is_byte(full_flags):
    #     return 1
    # else:
    #     print(f"Unsupported data type at address {hex(ea)}")
    #     return None


def get_full_data(ea, size):
    # size = get_operand_size(ea)
    if not size:
        return None
    raw_data = idc.get_bytes(ea, size)
    if size == 4:
        data = struct.unpack('f', raw_data)[0]
    elif size == 8:
        data = struct.unpack('d', raw_data)[0]
    else:
        data = None
    # hex_data = " ".join(f"{b:02X}" for b in raw_data)
    return data

def get_data_content(ea, size):
    print(f"is_loaded: {idc.is_loaded(ea)}")
    # 如果数据区域没有被初始化，则返回0（如.bss段）
    if not idc.is_loaded(ea): 
        return 0
    if size == 1:
        return ida_bytes.get_byte(ea)
    elif size == 2:
        return ida_bytes.get_word(ea)
    elif size == 4:
        return ida_bytes.get_dword(ea)
    elif size == 8:
        return ida_bytes.get_qword(ea)
    else:
        print(f"Unsuppored data size {size} at addr {ea}")
        return None

def format_fp_imm(fp_imm):
    return "0x" + f"{fp_imm:<016x}".upper()

def in_read_only_section(ea):
    perm = idc.get_segm_attr(ea, idc.SEGATTR_PERM)
    # print(f"writable: {perm & ida_segment.SEGPERM_WRITE}")
    # print(f"executable: {perm & ida_segment.SEGPERM_EXEC}")
    return not (perm & ida_segment.SEGPERM_WRITE or perm & ida_segment.SEGPERM_EXEC)

def in_non_exec_section(ea):
    perm = idc.get_segm_attr(ea, idc.SEGATTR_PERM)
    # print(f"writable: {perm & ida_segment.SEGPERM_WRITE}")
    # print(f"executable: {perm & ida_segment.SEGPERM_EXEC}")
    return not perm & ida_segment.SEGPERM_EXEC

def is_fp_imm(data_ea, insn_ea):
    ff = idc.get_full_flags(data_ea)
    return ((is_immediate(data_ea) and is_float_point_insn(insn_ea)) or is_double(data_ea)) \
        and in_read_only_section(data_ea)

def is_strlit(data_ea):
    ff = idc.get_full_flags(data_ea)
    return idc.is_data(ff) and idc.is_strlit(ff)

def is_func_start(insn_ea):
    ff = idc.get_full_flags(insn_ea)
    return idc.is_code(ff) and idc.get_func_attr(insn_ea, idc.FUNCATTR_START) == insn_ea

def get_hex_data(start_ea, size):
    """
    从指定起始地址读取指定大小的数据并转换为16进制表示。

    :param start_ea: 起始地址 (有效的虚拟地址)
    :param size: 要读取的数据大小 (字节数)
    :return: 转换后的16进制字符串
    """
    print(f"is_loaded: {idc.is_loaded(start_ea)}")
    # 如果数据区域没有被初始化，则返回0（如.bss段）
    if not idc.is_loaded(start_ea): 
        return 0

    # 初始化字节数组
    byte_array = []

    # 读取指定范围的数据
    for offset in range(size):
        byte_array.append(idc.get_wide_byte(start_ea + offset))

    # 返回拼接的16进制表示
    return int.from_bytes(byte_array, byteorder="little")

jcc_opcodes = [
    "ja", "jae", "jb", "jbe", "jc", "jcxz", "jecxz", "jrcxz", "je", "jg", 
    "jge", "jl", "jle", "jna", "jnae", "jnb", "jnbe", "jnc", "jne", "jng", 
    "jnge", "jnl", "jnle", "jno", "jnp", "jns", "jnz", "jo", "jp", "jpe", 
    "jpo", "js", "jz"
]

jump_opcodes = jcc_opcodes.copy()
jump_opcodes.append("jmp")

def is_fallthru_of_jcc(fallthru_addr):
    xrefs = idautils.XrefsTo(fallthru_addr, ida_xref.XREF_ALL)

    for xref in xrefs:
        # 获取引用的地址
        ref_address = xref.frm
        
        # 解码指令
        insn = idautils.DecodeInstruction(ref_address)
        # 检查指令是否为跳转指令
        if insn and insn.get_canon_mnem() in jcc_opcodes:
            # 检查跳转指令的目标地址
            if xref.type == 21: # Ordinary Flow
                return True
    return False

def is_target_of_jmp(target_address):
    xrefs = idautils.XrefsTo(target_address, ida_xref.XREF_ALL)
    for xref in xrefs:
        # 获取引用的地址
        ref_address = xref.frm
        insn = idautils.DecodeInstruction(ref_address)
        # 检查指令是否为跳转指令
        if insn and insn.get_canon_mnem() in jump_opcodes:
            # 检查跳转指令的目标地址
            insn_target_address = idc.get_operand_value(ref_address, 0)
            if insn_target_address == target_address:
                return True
    return False

def is_jmp(ea):
    mnemonic = idc.print_insn_mnem(ea)
    return mnemonic in jump_opcodes


def is_float_point_insn(ea):
    mnemonic = idc.print_insn_mnem(ea)
    # print(mnemonic)
    sse_mnemonics = [
        "movaps", "movups", "movss", "movdqu",
        "addps", "addss", "subps", "subss",
        "mulps", "mulss", "divps", "divss",
        "pxor", "paddd", "movsd"
    ]
    return mnemonic in sse_mnemonics

def get_data_type_str_from_ea(ea):
    size = idc.get_item_size(ea)
    #　处理浮点的情况
    xrefs = idautils.XrefsTo(ea, ida_xref.XREF_ALL)
    for xref in xrefs:
        if is_float_point_insn(xref.frm):
            return get_data_type_str(size, True)
    return get_data_type_str(size, False)

def get_data_type_str(size, is_float=False):
    if is_float:
        if size == 4:
            return "float"
        elif size == 8:
            return "double"
        else:
            print(f"Unrecognized Type with size {size}, is_float = {is_float}")
            return "Unknown integer"
    else:
        if size == 4:
            return "i32"
        elif size == 8:
            return "i64"
        elif size == 2:
            return "i16"
        elif size == 1:
            return "i8"
        else:
            print(f"Unrecognized Type with size {size}, is_float = {is_float}")
            return "Unknown float"
    return "Unknown"

def get_insn_type(ea):
    if not idc.is_code(idc.get_full_flags(ea)):
        return None
    return InsnType.InsnFloat if is_float_point_insn(ea) else InsnType.InsnInt


def convert_hex_to_decimal(input_str):
    """
    将十六进制数字字符串转换为十进制表示。
    - 以 '0x' 开头或以 'h' 结尾的字符串视为十六进制数字。
    - 如果不是十六进制数字，返回原始字符串。
    """
    input_str = input_str.strip()  # 去掉两端的空白字符
    
    # 匹配以 '0x' 开头的十六进制数字
    if re.fullmatch(r"0x[0-9a-fA-F]+", input_str):
        return str(int(input_str, 16))
    
    # 匹配以 'h' 结尾的十六进制数字（去掉 h 后检查是否为有效十六进制数字）
    if re.fullmatch(r"[0-9a-fA-F]+h", input_str):
        hex_part = input_str[:-1]  # 去掉末尾的 'h'
        return str(int(hex_part, 16))
    
    # 如果不符合十六进制格式，返回原始字符串
    return input_str

def replace_imm_with_decimal(ea, origin_disasm):
    imm_replace_list = []

    for i in range(2):
        op_type = idc.get_operand_type(ea, i)
        if op_type == idc.o_imm:
            imm_value = idc.get_operand_value(ea, i)
            imm_value_str = idc.print_operand(ea, i)
            print(f"Got immediate value {imm_value} in instruction at {ea}")
            imm_replace_list.append((imm_value_str, imm_value))
    
    # print(f"origin_disasm={origin_disasm}")
    insn = IDAProInstruction.from_disasm_string(origin_disasm)

    # op_str = insn.op_str.split(",")
    # for imm_value_str, imm_value in imm_replace_list:
    #     for opr in op_str.split(","):
    #         if imm_value_str in opr.strip():
    #             opr.replace(imm_value_str, str(imm_value))
    
    opr_list = []
    for opr in insn.op_str.split(","):
        print(f"old opr is {opr}")
        new_opr = opr
        for imm_value_str, imm_value in imm_replace_list:
            if imm_value_str == opr.strip():
                new_opr = opr.replace(imm_value_str, str(imm_value))
                print(f"new opr is {new_opr}")
        opr_list.append(new_opr)
    
    insn.op_str = ",".join(opr_list)

    return f"{insn}"
    #         imm_replace_list
    # return None, None


def get_all_funcs():
    all_funcs = []
    for func_ea in idautils.Functions():
        # @todo: 0x5410的规律是否一定成立？
        if idc.get_func_flags(func_ea) == 0x5410:
            all_funcs.append(idc.get_func_name(func_ea))
    return all_funcs

# def get_next_padding_symbol(ea):
#     segm_end = idc.get_segm_end(ea)
#     for current_ea in sorted(idautils.Heads()):
#         if current_ea >= segm_end:
#             break
#         if current_ea > ea and is_padding(current_ea):
#             return current_ea
#     return segm_end

def get_next_non_dummy_symbol(ea):
    segm_end = idc.get_segm_end(ea)
    for current_ea, name in sorted(idautils.Names(), key=lambda x: x[0]):
        if current_ea >= segm_end:
            break
        if current_ea > ea and has_non_dummy_name(current_ea):
            return current_ea
    return segm_end

def get_next_immediate(ea):
    segm_end = idc.get_segm_end(ea)
    for current_ea in sorted(idautils.Heads()):
        if current_ea >= segm_end:
            break
        if current_ea > ea and is_immediate(current_ea):
            return current_ea
    return segm_end

def get_next_string(ea):
    segm_end = idc.get_segm_end(ea)
    for current_ea in sorted(idautils.Heads()):
        if current_ea >= segm_end:
            break
        if current_ea > ea and is_string_symbol(current_ea):
            return current_ea
    return segm_end

def dump_data_xref(head):
    print(f"data item: ============================")
    print(f"ea = {hex(head)}")
    print(f"name = {idc.get_name(head)}")
    print(f"size = {idc.get_item_size(head)}")
    ff = idc.get_full_flags(head)
    print(f"full_flags = {hex(ff)}")
    print(f"is data: {idaapi.is_data(ff)}")
    print(f"is code: {idaapi.is_code(ff)}")
    print(f"is float: {idaapi.is_float(ff)}")
    print(f"is double: {idaapi.is_double(ff)}")
    print(f"is string: {idaapi.is_strlit(ff)}")
    print(f"is align: {idaapi.is_align(ff)}")
    print(f"is oword: {idaapi.is_oword(ff)}")
    print(f"is qword: {idaapi.is_qword(ff)}")
    print(f"is dword: {idaapi.is_dword(ff)}")
    print(f"is word: {idaapi.is_word(ff)}")
    print(f"is byte: {idaapi.is_byte(ff)}")

    print(f"has xref: {idaapi.has_xref(ff)}")
    print(f"has non-dummy name: {idaapi.has_name(ff)}")
    print(f"has dummy name: {idaapi.has_dummy_name(ff)}")
    print(f"has auto name: {idaapi.has_auto_name(ff)}")
    print(f"has any name: {idaapi.has_any_name(ff)}")

    print(f"instructions that refers to data at {hex(head)}:")
    for code in idautils.CodeRefsTo(head, 0):
        print(code)
        print(idc.generate_disasm_line(code, 0))

    print(f"instructions that refers from data at {hex(head)}:")
    for code in idautils.CodeRefsFrom(head, 1):
        print(code)
        print(idc.generate_disasm_line(code, 0))

    print(f"data refers from data at {hex(head)}:")
    for data in idautils.DataRefsFrom(head):
        print(f"\tea = {hex(data)}")
        print(f"\tname = {idc.get_name(data)}")
        print(f"\tsize = {idc.get_item_size(data)}")
        # print(f"\tref_type = {idautils.XrefTypeName()}")

    print(f"data refers to data at {hex(head)}:")
    for data in idautils.DataRefsTo(head):
        print(f"\tea = {hex(data)}")
        print(f"\tname = {idc.get_name(data)}")
        print(f"\tsize = {idc.get_item_size(data)}")
        
    print(f"ALL xrefs to data at {hex(head)}:")
    for xref in idautils.XrefsTo(head, ida_xref.XREF_ALL):
        print(xref.type, idautils.XrefTypeName(xref.type), \
                'from', hex(xref.frm), 'to', hex(xref.to))
        if idc.is_code(idc.get_full_flags(xref.frm)):
            print(f"\tis data: {idc.is_data(idc.get_full_flags(xref.frm))}")
            print(f"\tinsn at {hex(xref.frm)}")
            print(f"\t{idc.generate_disasm_line(xref.frm, 0)}")
            print(f"\tfull_flags = {hex(idc.get_full_flags(xref.frm))}")
            print(f"\tis float0 = {idaapi.is_float0(idc.get_full_flags(xref.frm))}")
            print(f"\tis float1 = {idaapi.is_float1(idc.get_full_flags(xref.frm))}")
            print(f"\thas immd = {idaapi.has_immd(idc.get_full_flags(xref.frm))}")
            # print(f"\tis float = {.is_float(idc.get_full_flags(xref.frm), idaapi.OPND_ALL)}")
        else:
            assert(idc.is_data(idc.get_full_flags(xref.frm)))
            print(f"\tdata at {hex(xref.frm)}")
            print(f"\tea = {hex(xref.frm)}")
            print(f"\tname = {idc.get_name(xref.frm)}")
            print(f"\tsize = {idc.get_item_size(xref.frm)}")
            print(f"\t{hex(idc.get_full_flags(xref.frm))}")

            

    print(f"ALL xrefs from data at {hex(head)}:")
    for xref in idautils.XrefsFrom(head, ida_xref.XREF_ALL):
        print(xref.type, idautils.XrefTypeName(xref.type), \
                'from', hex(xref.frm), 'to', hex(xref.to))
        if idc.is_code(idc.get_full_flags(xref.to)):
            print(f"\tis data: {idc.is_data(idc.get_full_flags(xref.to))}")
            print(f"\tinsn at {hex(xref.to)}")
            print(f"\t{idc.generate_disasm_line(xref.to, 0)}")
            print(f"\t{hex(idc.get_full_flags(xref.to))}")
        else:
            assert(idc.is_data(idc.get_full_flags(xref.to)))
            print(f"\tdata at {hex(xref.to)}")
            print(f"\tea = {hex(xref.to)}")
            print(f"\tname = {idc.get_name(xref.to)}")
            print(f"\tsize = {idc.get_item_size(xref.to)}")
            print(f"\tfull_flags = {hex(idc.get_full_flags(xref.to))}")
