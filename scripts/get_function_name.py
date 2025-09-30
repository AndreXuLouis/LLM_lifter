import sys
import re
from elftools.elf.elffile import ELFFile

def is_c_runtime_function(func_name):
    # 定义一些常见的 C 运行时函数名称
    # @todo: 完善各种情况
    c_runtime_funcs = {
        '_start', 'exit', 'abort', 'malloc', 'free', 'printf', 'scanf',
        'frame_dummy', 'deregister_tm_clones', 'register_tm_clones',
        'printf', '__do_global_dtors_aux', '_fini', '_init',
    }
    return func_name in c_runtime_funcs \
        or func_name.startswith('__libc_') \
        or "@@" in func_name \
        or "@" in func_name \
        or func_name.startswith('_') \

def extract_non_runtime_function_names(elf_file_path):
    with open(elf_file_path, 'rb') as file:
        elffile = ELFFile(file)

        # 获取符号表
        symtab = elffile.get_section_by_name('.symtab')
        if not symtab:
            print("没有找到符号表。")
            return

        non_runtime_function_names = []

        # 遍历符号表中的所有符号
        for symbol in symtab.iter_symbols():
            if symbol['st_info']['type'] == 'STT_FUNC':  # 只考虑函数类型
                func_name = symbol.name
                if not is_c_runtime_function(func_name):
                    non_runtime_function_names.append(func_name)

        return non_runtime_function_names

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 get_function.py /path/to/binary")
        sys.exit(1)

    elf_file_path = sys.argv[1]
    non_runtime_function_names = extract_non_runtime_function_names(elf_file_path)

    if non_runtime_function_names:
        # print("找到的非 C 运行时函数名:")
        for name in non_runtime_function_names:
            print(name)
    else:
        print("没有找到非 C 运行时函数。")
