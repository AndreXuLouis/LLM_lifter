import idc
import idautils
import ida_xref
from enum import Enum, auto
from ida_utils import *
from LLVMDataType import *

data_segments = [".data", ".bss", ".rodata"]
POINTER_SIZE = 8


# class DataAccessPattern:
#     def __init__(self, size, insn_type):
#         self.size = size
#         self.insn_type = insn_type


def get_nearest_name_in_range(ea, segment_start, segment_end):
    """Find the nearest named symbol before the given address."""
    assert(ea <= segment_end)
    current_ea = ea - 1
    while current_ea >= segment_start:
        name = idc.get_name(current_ea)
        if name != '' and \
            not has_dummy_name(current_ea) and \
            not has_auto_name(current_ea) and \
            idc.is_data(idc.get_full_flags(current_ea)):
            return name, ea - current_ea
        current_ea -= 1
    return None, None

# def get_nearest_name(data_ea):
#     print(idc.get_name(data_ea))
#     for seg_ea in idautils.Segments():
#         seg_start = seg_ea
#         seg_end = idc.get_segm_end(seg_ea)
#         size = idc.get_item_size(data_ea)
#         if idc.get_segm_name(seg_ea) == 'LOAD':
#             continue
#         if size > 0 and data_ea >= seg_start and data_ea + size < seg_end:
#             # print(hex(ea))
#             # print(idc.get_segm_name(ea))
#             # print(hex(seg_start))
#             # print(hex(seg_end))
#             name, offset = get_nearest_name_in_seg(data_ea, seg_start, seg_end)
#             return name, offset + data_ea
#     return None

def rename_dummy_symbols():    
    substitutions = {}
    nearest_name_for_dummy_name = {}

    # Process each segment
    for seg in data_segments:
        seg_sel = idc.selector_by_name(seg)
        if seg_sel == idc.BADADDR:
            print(f"Segment {seg} not found. Skipping.")
            continue
        
        seg_start = idc.get_segm_by_sel(seg_sel)
        seg_end = idc.get_segm_end(seg_start)
        print(f"Processing segment: {seg} (start: {hex(seg_start)}, end: {hex(seg_end)})")
        
        # Iterate over symbols in the segment
        for ea in idautils.Heads(seg_start, seg_end):
            if not idc.is_data(idc.get_full_flags(ea)):  # Skip non-data symbols
                continue
            
            if has_dummy_name(ea) and not is_string_symbol(ea) and not is_immediate(ea):  # Check if the symbol is a dummy name
                nearest_name, offset = get_nearest_name_in_range(ea, seg_start, seg_end)
                if nearest_name:
                    new_name = f"{nearest_name}+{offset}"
                    substitutions[idc.get_name(ea)] = new_name
                    nearest_name_for_dummy_name[idc.get_name(ea)] = nearest_name
                else:
                    print(f"No nearest symbol found for {hex(ea)}")
            else:
                if is_string_symbol(ea):
                    print(f"Skipping {hex(ea)}: Is a string name")
                else:
                    print(f"Skipping {hex(ea)}: Nor a string name or dummy name")
    
    return substitutions, nearest_name_for_dummy_name

def symbol_need_not_analyze(ea):
    name_list = [
        "__bss_start",
        "__dso_handle",
        "__data_start",
        "_IO_stdin_used",
    ]

    return idc.get_name(ea) in name_list

def get_segment_non_dummy_data_symbols(segname):
    """
    获取指定段中的所有非哑名数据符号地址及其大小。
    返回根据符号地址从小到达排序的序列
    """
    symbols = []
    for ea in idautils.Segments():
        # print(f"seg_name = {idc.get_segm_name(ea)}")
        # print(f"seg_ea = {hex(ea)}")
        # print(f"seg_st = {hex(idc.get_segm_start(ea))}")
        assert(ea == idc.get_segm_start(ea))
        if not idc.get_segm_name(ea) == segname:
            continue
        start = idc.get_segm_start(ea)
        end = idc.get_segm_end(ea)
        # print(f"\tname = {idc.get_name(ea)}")
        # for ea in idautils.Heads(start, end):
        for ea, _ in idautils.Names():
            if ea < start or ea >= end:
                continue
            if not has_any_name(ea):
                continue
            if has_dummy_name(ea) or has_auto_name(ea):
                continue
            if symbol_need_not_analyze(ea):
                continue
            name = idc.get_name(ea)
            # if not idc.is_data(idc.get_full_flags(ea)):  # Skip non-data symbols
            #     continue
            # if is_dummy_name(ea):  # Check if the symbol is a dummy name
            #     continue
            # name = idc.get_name(ea)
            # if name == '':                # 特殊情况处理
            #     continue
            # @todo: idc.get_item_size可能不精确（如果ea没有被访问过的话）
            size = idc.get_item_size(ea)
            symbols.append((ea, size, name))
    return sorted(symbols, key=lambda x: x[0])


def get_data_access_pattern(ea):
    """
    判断ea处数据的访问模式
    """
    # access_pattern = (大小，指令类型)
    access_pattern = set()
    if not idc.is_data(idc.get_full_flags(ea)):
        return None
    size = idc.get_item_size(ea)
    xrefs = idautils.XrefsTo(ea, ida_xref.XREF_ALL)
    for xref in xrefs:
        # todo: 向量指令
        insn_type = get_insn_type(xref.frm)
        print(f"Reference from {hex(xref.frm)} to {hex(xref.to)} Type: {idautils.XrefTypeName(xref.type)}")
        print(f"access insn = {idc.generate_disasm_line(xref.frm, 0)}")
        if insn_type:
            access_pattern.add((size, insn_type))
    return access_pattern


def analyze_memory_gap(start, end):
    """
    分析内存空洞中被访问的模式，返回其访问的类型集合与该区域中被访问的次数。
    """
    access_patterns = set()
    ea = start
    access_times = 0
    for ea in idautils.Heads(start, end):
        if idc.get_name(ea) == '':
            continue
        if not idc.is_data(idc.get_full_flags(ea)):
            continue
        access_pattern = get_data_access_pattern(ea)
        access_patterns = access_patterns.union(access_pattern)
        access_times += 1
    return access_patterns, access_times

def get_symbol_size_from_insns(ea, insns):
    data_access_pattern = set()
    for insn_ea in insns:
        symbol_size = get_operand_size(insn_ea, ea)
        is_fp_insn = is_float_point_insn(insn_ea)
        data_access_pattern.add((symbol_size, is_fp_insn))
    if len(data_access_pattern) != 1:
        return None
    else:
        return symbol_size

def get_insn_ref_to_with_data_rw(ea):
    insns = []
    for xref in idautils.XrefsTo(ea, ida_xref.XREF_ALL):
        print(xref.type, idautils.XrefTypeName(xref.type), \
                'from', hex(xref.frm), 'to', hex(xref.to))
        if is_code(xref.frm) and \
            (xref.type == 2 or xref.type == 3): # Data_Read or Data_Write
            insns.append(xref.frm)
    return insns

def get_data_type(size, is_float_insn):
    if is_float_insn:
        return LLVMFloat(size)
    else:
        return LLVMInteger(size)

def get_data_at(start_ea, size):
    byte_array = []
    for offset in range(size):
        byte_array.append(idc.get_wide_byte(start_ea + offset))
    return byte_array

def get_pointer_data_at(start_ea, size):
    pointer_array = []
    offset = 0
    while offset < size:
        target_ea, target_name = None, None
        for xref in idautils.XrefsFrom(start_ea + offset, ida_xref.XREF_ALL):
            # print(xref.type, idautils.XrefTypeName(xref.type), \
            #         'from', hex(xref.frm), 'to', hex(xref.to))
            if is_data(xref.to) and xref.type == 1: # Data_Offset
                target_ea = xref.to
                target_name = idc.get_name(xref.to)
        pointer_array.append((target_ea, target_name))
        offset += POINTER_SIZE
    return pointer_array

def analyze_elem_data_type(ea, gap_size):
    data_access_pattern = set()
    for head in idautils.Heads(ea, ea + gap_size):
        insns = get_insn_ref_to_with_data_rw(head)
        for insn in insns:
            size = get_operand_size(insn, head)
            data_access_pattern.add((size, is_float_point_insn(insn)))
    
    if len(data_access_pattern) == 0 or len(data_access_pattern):
        return LLVMUnknown()
    else:
        return get_data_type(size, data_access_pattern.pop()[1])

def has_data_offset_xref_from(ea, gap_size):
    offset = 0
    while offset < gap_size:
        for xref in idautils.XrefsFrom(ea + offset, ida_xref.XREF_ALL):
            print(xref.type, idautils.XrefTypeName(xref.type), \
                    'from', hex(xref.frm), 'to', hex(xref.to))
            if is_data(xref.to) and xref.type == 1: # Data_Offset
                return True
        offset += POINTER_SIZE
    return False

def analyze_pointee_type(ea, gap_size):
    pointee_types = set()
    offset = 0
    while offset < gap_size:
        for xref in idautils.XrefsFrom(ea + offset, ida_xref.XREF_ALL):
            print(xref.type, idautils.XrefTypeName(xref.type), \
                    'from', hex(xref.frm), 'to', hex(xref.to))
            if is_data(xref.to) and xref.type == 1: # Data_Offset
                # 字符串特殊处理
                if is_string_symbol(xref.to):
                    pointee_type = LLVMInteger(1) # i8
                else:
                    pointee_type, _ = analyze_data_type(xref.to)
                return pointee_type
        offset += POINTER_SIZE
    return LLVMUnknown()

def analyze_data_type(ea):
    MAX_PRIMITIVE_DATA_TYPE_SIZE = 8
    if not in_read_only_section(ea):
        gap_size = get_next_non_dummy_symbol(ea) - ea
    else:
        gap_size = min(get_next_non_dummy_symbol(ea),
                       get_next_immediate(ea),
                       get_next_string(ea)) - ea
    
    print(f"\tgap_size = {gap_size}")
    
    data_type, init_data = None, []

    insns = get_insn_ref_to_with_data_rw(ea)
    if insns:
        symbol_size = get_symbol_size_from_insns(ea, insns)
        if symbol_size == gap_size:
            data_type = get_data_type(symbol_size, is_float_point_insn(insns[0]))
        else:
            elem_type = get_data_type(symbol_size, is_float_point_insn(insns[0]))
            data_type = LLVMArray(elem_num=gap_size//elem_type.get_size(), elem_type=elem_type)
    else:
        if gap_size > MAX_PRIMITIVE_DATA_TYPE_SIZE:
            elem_type = analyze_elem_data_type(ea, gap_size)
            if elem_type.is_unknown():
                data_type = LLVMArray(elem_num=gap_size, elem_type=LLVMInteger(1))
            else:
                data_type = LLVMArray(elem_num=gap_size//elem_type.get_size(), elem_type=elem_type)
        else:
            data_type = LLVMArray(elem_num=gap_size, elem_type=LLVMInteger(1))
    
    # 对指针变量的修正
    has_ptr = False
    if idc.is_loaded(ea):
        if data_type.is_primitive_type() and data_type.get_size() == POINTER_SIZE:
            if has_data_offset_xref_from(ea, POINTER_SIZE):
                pointee_type = analyze_pointee_type(ea, gap_size)
                data_type = LLVMPtr(pointee_type)
                has_ptr = True
        elif data_type.is_aggregate_type() and data_type.elem_type.get_size() == POINTER_SIZE:
            if has_data_offset_xref_from(ea, gap_size):
                pointee_type = analyze_pointee_type(ea, gap_size)
                data_type.elem_type = LLVMPtr(pointee_type)
                has_ptr = True

    # 读取数据
    if has_ptr:
        init_data = get_pointer_data_at(ea, gap_size)
    elif idc.is_loaded(ea):
        init_data = get_data_at(ea, gap_size)
    return data_type, init_data

def infer_symbol_type(symbols):
    """
    根据符号及其后续内存空洞分析指针类型。
    返回分析结果的字典，键为符号名称，值为推断的类型。
    """
    result = {}
    for i, (ea, size, name) in enumerate(symbols):
        # 只分析非哑名的符号信息
        assert(not has_dummy_name(ea) and not has_auto_name(ea))
        # next_ea = symbols[i + 1][0] if i + 1 < len(symbols) else idc.get_segm_end(ea)
        # gap_start = ea
        # gap_end = next_ea

        print(f"Analyzing symbol {name}")
        # print(f"\tgap_start = {hex(gap_start)}")
        # print(f"\tgap_end = {hex(gap_end)}")
        # print(f"\tsize = {hex(size)}")

        # dump_data_xref(ea)

        data_type, init_data = analyze_data_type(ea)
        print(f"data_type = {data_type}")
        if init_data:
            print(f"init_data = {init_data}")
        else:
            print(f"init_data = zeroinitializer")
        # 如果内存空洞比符号本身大，分析其访问模式
        result[name] = (data_type, init_data)

        # if gap_end - gap_start > size:
        #     access_patterns, access_times = analyze_memory_gap(gap_start, gap_end)
        #     print(f"access_patterns = {access_patterns}")
        #     print(f"access_times = {access_times}")
        #     if access_times <= 0: # 如果该区域一次都没访问过，无法确定该符号的类型
        #         result[name] = LLVMUnknown()
        #     if len(access_patterns) == 1: #如果只有一种访问模式，则可以近似确定该符号指针指向的类型
        #         size, insn_type = access_patterns.pop()
        #         if insn_type.is_int():
        #             result[name] = LLVMPtr(LLVMInteger(size))
        #         elif insn_type.is_float():
        #             result[name] = LLVMPtr(LLVMFloat(size))
        #         else:
        #             result[name] = LLVMPtr()
        #     else: #如果有多种访问模式，无法确定类型
        #         result[name] = LLVMPtr()
        # else:
        #     # access_pattern = get_data_access_pattern(ea)
        #     # print(access_pattern)
        #     # # assert(len(access_pattern) == 1)
        #     # size, insn_type = access_pattern.pop()
        #     # if insn_type.is_int():
        #     #     result[name] = LLVMInteger(size)
        #     # elif insn_type.is_float():
        #     #     result[name] = LLVMFloat(size)
        #     # else:
        #     #     result[name] = LLVMUnknown()
        #     result[name] = LLVMUnknown()
    return result

def infer_global_var_type():
    analysis_results = {}

    for segment in data_segments:
        print(f"=====================")
        print(f"Analyzing segment: {segment}")
        symbols = get_segment_non_dummy_data_symbols(segment)

        if not symbols:
            print(f"No non-dummy symbols in segment {segment}")
            continue

        print(f"Non dummy symbols: ")
        for ea, size, name in symbols:
            print(f"\t{name}: {hex(ea)} {size}bytes")      
        
        segment_results = infer_symbol_type(symbols)
        print(f"segm results:")
        for name, (dtype, init_data) in segment_results.items():
            print(f"{name}: {dtype} {init_data}")
        
        analysis_results.update(segment_results)
    return analysis_results