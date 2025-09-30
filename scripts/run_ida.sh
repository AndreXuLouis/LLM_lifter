#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: ./run_ida.sh testcase_name"
else
    # 获取输入参数（不包含扩展名）
    INPUT=$1
    if [[ $INPUT == *.so ]]; then
        INPUT_BASENAME="${INPUT%.so}"
    else
        INPUT_BASENAME=$INPUT
    fi
    ~/idapro-9.0/idat64 -L~/ida.log -A -S"scripts/ida_extract_function_asm.py ${INPUT} ${INPUT_BASENAME}.x86_asm" ${INPUT}
fi