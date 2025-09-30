import re
import sys
import subprocess
from get_function_name import extract_non_runtime_function_names


def extract_function_from_ida(ida_output, function_name):
    # Regular expression pattern to match a function and its content
    # The pattern looks for the function label (`proc near`), the function content, and the end label (`endp`)
    pattern = re.compile(
        rf"({function_name} proc.*?{function_name} endp)", re.DOTALL
    )

    # Find all matching function definitions
    matches = pattern.findall(ida_output)

    if matches:    
        return matches[0]
    else:
        return f"Function '{function_name}' not found."


def extract_function_from_objdump(objdump_output, function_name):
    in_function = False
    function_instructions = []

    # 正则表达式匹配函数定义行
    function_pattern = re.compile(r"^\s*([0-9a-fA-F]+)\s+<([^>]+)>:")
    instruction_pattern = re.compile(r"^\s*([0-9a-fA-F]+):\s*")

    for line in objdump_output.splitlines():
        function_match = function_pattern.match(line)

        if function_match:
            current_function = function_match.group(2)
            if current_function == function_name:
                in_function = True
                function_instructions.append(line.strip())  # 添加函数定义行
            else:
                if in_function:
                    # 如果离开了目标函数，结束提取
                    break
        elif in_function:
            # 继续添加指令到当前函数
            instruction_match = instruction_pattern.match(line)
            if instruction_match:
                function_instructions.append(line.strip())

    return function_instructions


def extract_data_from_objdump(objdump_output):
    extracting = False
    extracted_lines = []
    data_header_pattern = re.compile(r"^\s*([0-9a-fA-F]+)\s+<([^>]+)>:")

    for line in objdump_output.splitlines():
        if data_header_pattern.match(line):
            extracting = True

        if extracting:
            extracted_lines.append(line)

    return extracted_lines


def run_objdump(executable_path, section=""):
    # 执行 objdump 命令并获取输出
    try:
        if section == "":
            result = subprocess.run(
                ["objdump", "-d", executable_path],
                capture_output=True,
                text=True,
                check=True,
            )
        else:
            result = subprocess.run(
                ["objdump", "-dz", "-j", section, executable_path],
                capture_output=True,
                text=True,
                check=True,
            )
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"执行 objdump 失败: {e}")
        sys.exit(1)


def run(executable_path, assembly_path):
    # 执行 objdump 命令
    objdump_output = run_objdump(executable_path)
    objdump_output_rodata = run_objdump(executable_path, section=".rodata")
    objdump_output_data = run_objdump(executable_path, section=".data")

    # 提取需要提升的函数
    target_function_list = extract_non_runtime_function_names(executable_path)

    # 去除数据段多余的解释
    objdump_output_rodata = extract_data_from_objdump(objdump_output_rodata)
    objdump_output_data = extract_data_from_objdump(objdump_output_data)

    # 提取指定函数的指令
    with open(assembly_path, "w") as f:
        f.write("Disassembly of section .text:\n")
        for target_function in target_function_list:
            instructions = extract_function_from_objdump(
                objdump_output, target_function
            )
            # 打印提取结果
            if instructions:
                print(f"函数 {target_function} 已找到保存到 {assembly_path}")
                for instruction in instructions:
                    f.write(instruction + "\n")
            else:
                print(f"未找到函数: {target_function}")
                sys.exit(-1)

        f.write("Disassembly of section .rodata:\n")
        for data in objdump_output_rodata:
            f.write(data + "\n")
        print(f".rodata段已经保存到 {assembly_path}")
        f.write("Disassembly of section .data:\n")

        for data in objdump_output_data:
            f.write(data + "\n")
        print(f".data段已经保存到 {assembly_path}")


def extract_function(executable_path, ida_output, func_output):
    # # 执行 objdump 命令
    # objdump_output = run_objdump(executable_path)
    # Read the IDA Pro assembly file content
    with open(ida_output, 'r') as file:
        ida_output = file.read()
    # 提取需要提升的函数
    target_function_list = extract_non_runtime_function_names(executable_path)

    with open(func_output, "w") as f:
        # f.write("Disassembly of section .text:\n")
        for target_function in target_function_list:
            instructions = extract_function_from_ida(
                ida_output, target_function
            )
            # 打印提取结果
            if instructions:
                print(f"函数 {target_function} 已找到保存到 {func_output}")
                for instruction in instructions:
                    f.write(instruction)
                f.write("\n\n")
            else:
                print(f"未找到函数: {target_function}")
                sys.exit(-1)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("usage: python extract_objdump_function.py /path/to/binary /path/to/ida_output /path/to/function_output")
        sys.exit(1)

    executable_path = sys.argv[1]
    ida_output = sys.argv[2]
    function_output = sys.argv[3]

    extract_function(executable_path=executable_path, ida_output=ida_output, func_output=function_output)
    # # Read the IDA Pro assembly file content
    # with open('../tmpfiles/access-stack-at-positive-offset.c.tmp-opt.asm', 'r') as file:
    #     ida_output = file.read()

    # # Specify the function name you want to extract
    # function_name = 'main'

    # # Extract and print the function
    # extracted_function = extract_function_from_ida(ida_output, function_name)
    # print(extracted_function)
