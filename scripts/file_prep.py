import re
import argparse

def process_c_file(input_file, output_file):
    with open(input_file, 'r') as f:
        content = f.readlines()

    # 处理每一行，查找并替换 RUN 语句
    processed_content = []
    target_file = None
    for line in content:
        match = re.search(r'-o\s+([^\s]+)', line)
        if match and not ".ll" in line:
            target_file = match.group(1)
        # 将-dis.ll替换成-llm-dis.ll
        line = re.sub(r"-dis\.ll", "-llm-dis.ll", line)
        # 如果是 RUN 注释，将其替换为目标格式
        if line.strip().startswith("// RUN"):
            # 判断原始 RUN 行的内容并进行替换
            if "llvm-mctoll" in line:
                # 将含有mctoll的行修改为 ida_bin + lifter
                if target_file:
                    target_file_basename = target_file.removesuffix(".so")
                    processed_content.append(f"// RUN: %ida_bin -A -S\"%ida_script {target_file} {target_file_basename}.x86_asm\" {target_file}\n")
                    processed_content.append(f"// RUN: python3 %lifter {target_file}\n")
                else:
                    processed_content.append("// RUN: %ida_bin -A -S\"%ida_script %t %t.x86_asm\" %t\n")
                    processed_content.append("// RUN: python3 %lifter %t\n")
            else:
                processed_content.append(line)
        elif not line.strip().startswith("// REQUIRES"):
            # 保留其他注释如 REQUIRES 和 CHECK 等
            processed_content.append(line)

    # 将处理后的内容写入输出文件
    with open(output_file, 'w') as f:
        f.writelines(processed_content)

    print(f"Processed file saved to: {output_file}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process a C file and replace specific patterns in RUN commands.')
    parser.add_argument('input_file', help='The input C file to process')
    parser.add_argument('output_file', help='The output C file to save the processed content')

    # 解析命令行参数
    args = parser.parse_args()

    # 调用处理函数
    process_c_file(args.input_file, args.output_file)
