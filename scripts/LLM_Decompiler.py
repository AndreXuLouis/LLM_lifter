# interactive version of LLM-assisted lifter

# 在85-86行，定义了json输出的形式
# 在120-125行，对返回结果做了json化处理，并提取出提升结果直接存到tmpfiles中的*.ll文件中

from openai import OpenAI
import openai
from pydantic import BaseModel
import json
import subprocess
import sys
import os
import time
import json
import argparse
from utils import generate_feedback_prompt, replace_line_in_file
from utils import FixType, ErrorType, ClangError
from utils import LLMLifterConfig
from utils import data_preprocess
# from utils import extract_error_line
# import extract_function_asm

class LiftJsonOutput(BaseModel):
    lift_json: str

if __name__ == '__main__':
    # config = LLMLifterConfig.parse_arguments()
    # print(config)
    
    # tmpfile_dir = f"{config.test_dir}/{config.tmpfile_dir}"

    # if config.lift_func:
    #     function_asm = f"{tmpfile_dir}/{config.binary}.{config.lift_func}.x86_asm"
    # else:
    #     function_asm = f"{tmpfile_dir}/{config.binary}.x86_asm"
    # if not os.path.isfile(function_asm):
    #     raise FileNotFoundError(f"file {function_asm} not exist")

    # liftfunc_suffix = "" if not config.lift_func else f"{config.lift_func}."

    # gpt_function_ll = f"{tmpfile_dir}/{config.binary}-llm-dis.{liftfunc_suffix}ll"
    # gpt_function_bin = f"{tmpfile_dir}/{config.binary}-llm-dis.{liftfunc_suffix}o"
    # prompts_save_file_prefix = f"{config.test_dir}/prompts/{config.binary}.{liftfunc_suffix}pmt"
    # gpt_function_save_file_prefix = f"{config.test_dir}/gpt_functions/{config.binary}-llm-dis{liftfunc_suffix}"
    # error_msg_save_file_prefix = f"{config.test_dir}/err_msgs/{config.binary}.{liftfunc_suffix}err"
    # success_turn_save_file = f"{config.test_dir}/iter_times/{config.binary}.{liftfunc_suffix}iter"

    function_asm = os.environ['HOME'] + "/function.s"
    with open(function_asm, "r") as f:
        code = f.read()
    print(f"read function assembly code from {function_asm}")

    init_prompts = [
        {
            "role": "system",
            "content": """ Generate linux compilable C code of functions in the supplied snippet \
                without using goto, fix any missing headers and reducing the number of intermediate variable. \
                Only reply the fixed source code. Do not explain anything and include any extra instructions, only \
                print the fixed source code.
            """
        },
        {
            "role": "user",
            "content": f"""<code> {code} </code>"""
        },
    ]

    prompts = init_prompts

    client = OpenAI()
    openai.api_request_timeout = 3600  # 超时时间为3600s
    time_start = time.time()

    # 生成初始结果
    print("===========================================")
    print("Generating initial decompiling results...")

    response_result = client.beta.chat.completions.parse(
        model="gpt-4o",
        messages=prompts,
        response_format=LiftJsonOutput,
        temperature=0,
    )

    print(f"Get response from model gpt-4o")
    data = json.loads(response_result.choices[0].message.content)
    C_decompiler = data["lift_json"]

    # C_decompiler = data_preprocess(C_decompiler)

    # ================= 中间文件保存 =====================
    gpt_function_save_file =  os.environ['HOME'] + "/fuction-decompiler.c"
    with open(gpt_function_save_file, "w") as f:
        f.write(C_decompiler)
    print(f"Initial decompiling results have been saved to {gpt_function_save_file}")
    # ===================================================

    # with open(gpt_function_ll, "w") as f:
    #     f.write(llvm_ir)

    exit(0)

    # 进行自修正
    turn = 0
    while turn < config.max_turn:
        # fix_type = FixType.File

        # ===================== Verifer =========================
        # 获取编译报错信息
        print("Compiling generated .ll file to executable file...")
        cmd = [
            "clang",
            "-c", # 生成目标文件，因为可能存在外部变量/函数引用
            gpt_function_ll,
            "-w", # ignore warning
            "-o",
            gpt_function_bin,
        ]
        compile_result = subprocess.run(cmd, capture_output=True, text=True)

        # 处理报错信息
        if compile_result.returncode == 0:
            print(f"Compile succeed at Turn {turn} fixing, save compiled binary in: {gpt_function_bin}")
            with open(success_turn_save_file, "w") as f:
                f.write(str(turn))
            break
        print(f"Failed to compile, get error message:\n{compile_result.stderr}")
        error_message = ClangError.parse(compile_result.stderr.splitlines()[0])
        if error_message == None:
            print(f"Failed to parse: {compile_result.stderr}")
            exit(-1)
        # ===================== Verifer =========================


        # ===================== Self Fixing ========================
        print("Generating feedback prompt according to error message...")
        # 根据报错信息生成反馈
        feedback_prompt = generate_feedback_prompt(
            ErrorType.CompileError, error_message, config.fix_type
        )
        prompts += feedback_prompt


        # 自修正
        turn = turn + 1

        print("===========================================")
        print(f"Turn {turn} fixing...")
        print(f"Fixtype is {config.fix_type.name}")

        response_result = client.beta.chat.completions.parse(
            model=config.model_name,
            messages=prompts,
            response_format=LiftJsonOutput,
            temperature=config.temperature,
        )

        print(f"Get response from model {config.model_name}")


        data = json.loads(response_result.choices[0].message.content)
        llvm_ir = data["lift_json"]

        llvm_ir = data_preprocess(llvm_ir)

        if config.fix_type == FixType.File:
            with open(gpt_function_ll, "w") as f:
                f.write(llvm_ir)
        elif config.fix_type == FixType.Func:
            print("not supported fix-type: Func")
            continue
        elif config.fix_type == FixType.Line:
            replace_line_in_file(gpt_function_ll, error_message.line, llvm_ir)

        print(f"Fixing results have been saved to {gpt_function_ll}")
        # ===================== Self Fixing ========================


        # =================== 中间文件保存 =============================
        print("Saving intermediate files...")
        # 保存大模型的回答
        gpt_function_save_file = f"{gpt_function_save_file_prefix}.{turn}.ll"
        with open(gpt_function_save_file, "w") as f:
            f.write(llvm_ir)
        print(f"LLM response has been saved to {gpt_function_save_file}")

        # 保存每轮的feedback prompt
        prompts_save_file = f"{prompts_save_file_prefix}.{turn}.json"
        with open(prompts_save_file, "w", encoding='utf-8') as f:
            json.dump(feedback_prompt, f, ensure_ascii=False, indent=4)
        print(f"Feedback prompt has been saved to {prompts_save_file}")

        # 保存每轮的error message
        error_msg_save_file = f"{error_msg_save_file_prefix}.{turn}"
        with open(error_msg_save_file, "w") as f:
            f.write(compile_result.stderr)
        print(f"Error message has been saved to {error_msg_save_file}")
        # # save response in responses/
        # with open(response_save_file + "." + str(turn), "w") as f:
        #     f.write(str(response_result))
        # # save generated LLVM IR in gpt_function_ir/
        # with open(gpt_function_save_file + "." + str(turn) + ".ll", "w") as f:
        #     f.write(response_result.choices[0].message.content)

        # save generated LLVM IR to gpt_funcion.ll for further processing
        # =============================================================

        # input("Press any key to continue...")
        # =================== 中间文件保存 =============================

    time_end = time.time()
    print("time cost ", time_end - time_start, "s")