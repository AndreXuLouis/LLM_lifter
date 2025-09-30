#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: ./run_test.sh testcase_name"
else

# 获取输入参数（不包含扩展名）
INPUT=$1

# 0. 删除临时文件
echo "removing temporary files..."
rm tmpfiles/${INPUT}.*

# 1. 使用 clang 编译输入文件
echo "compiling source to binary..."
clang -o tmpfiles/Output/${INPUT}.tmp testcases/${INPUT}

echo "disassembling binary ot assembly..."
# 2. 使用 IDA Pro 分析生成的二进制文件
/home/hxa/idapro-9.0/idat64 -A -S"scripts/ida_extract_function_asm.py tmpfiles/Output/${INPUT}.tmp tmpfiles/Output/${INPUT}.tmp.x86_asm" tmpfiles/Output/${INPUT}.tmp

echo "lifting assembly to LLVM IR & fixing..."
# 3. 使用 Python 脚本进行反汇编提升
python3 scripts/LLM_lifter.py --fix-type=File --max-turn=10 ${INPUT}.tmp

echo "Verifying correctness..."
# 4. 使用 clang 编译生成的 LLVM 汇编文件
clang -o tmpfiles/Output/${INPUT}.tmp-llm-dis tmpfiles/Output/${INPUT}.tmp-llm-dis.ll

# 5. 运行生成的可执行文件
./tmpfiles/Output/${INPUT}.tmp-llm-dis 2>&1 | FileCheck-14 testcases/${INPUT}

if [ $? -eq 0 ]; then
    echo "Test pass"
else
    echo "Test failed"
fi

fi