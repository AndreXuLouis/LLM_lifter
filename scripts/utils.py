import re
from enum import Enum
import argparse
import os

# class LiftType(Enum):
#     Func = 1
#     File = 2

class FixType(Enum):
    Line = 1
    Func = 2
    File = 3

class ErrorType(Enum):
    CompileError = 1
    LinkError = 2
    RunError = 3
    ResultMismatch = 4

class ClangError:
    def __init__(self, file: str, line: int, column: int, error_type: str, message: str):
        self.file = file            # 错误所在的文件
        self.line = line            # 错误所在的行号
        self.column = column        # 错误所在的列号
        self.error_type = error_type  # 错误类型（例如: 'error', 'warning' 等）
        self.message = message      # 错误信息

    def __str__(self):
        # 生成一个友好的错误描述
        return f"{self.error_type.upper()}: {self.message} (File: {self.file}, Line: {self.line}, Column: {self.column})"

    @staticmethod
    def parse(str_clang_error):
        error_pattern = re.compile(r"^(.*?):(\d+):(\d+):\s*(error|warning):\s*(.*)$")
        match = error_pattern.match(str_clang_error)
        if match:
            filename = match.group(1)  # 文件名
            line_number = int(match.group(2))  # 错误发生的行号
            column_number = int(match.group(3))  # 列号（如果需要）
            error_type = match.group(4)  # 错误类型
            error_message = match.group(5)  # 错误信息
            return ClangError(filename, line_number, column_number, error_type, error_message)
        return None

class LLMLifterConfig:
    def __init__(self):
        # self.lift_type = LiftType.File
        self.lift_func = ''
        self.fix_type = FixType.File   
        self.max_turn = 10
        self.model_name = "gpt-4o"  # Model name for the LLM
        self.temperature = 0.2    # Temperature for model sampling
        self.test_dir = os.path.dirname(os.path.dirname(__file__))
        self.tmpfile_dir = "tmpfiles/Output"
        self.binary: str

    # def __repr__(self):
    #     return (f"LLMLifterConfig(\n\tlift_type={self.lift_type},\n\tfix_type={self.fix_type},\n\t"
    #             f"max_turn={self.max_turn},\n\tmodel_name={self.model_name},\n\t"
    #             f"temperature={self.temperature},\n\ttest_dir={self.test_dir},\n\t"
    #             f"tmpfile_dir={self.tmpfile_dir},\n\tbinary={self.binary}\n\t)")

    def __repr__(self):
        # Collect all attributes dynamically
        attr_list = [f"\n\t{key}={repr(value)}" for key, value in self.__dict__.items()]
        # Format the output to mimic the constructor
        return f"{self.__class__.__name__}({', '.join(attr_list)}\n)"
    
    @staticmethod
    def parse_arguments():
        config = LLMLifterConfig()
        parser = argparse.ArgumentParser(description="LLM lifter")
        parser.add_argument('binary', type=str, help="Binary file ready to lift")
        parser.add_argument('--fix-type', choices=['File', 'Func', 'Line'], help="Specify the fix type", default='File')
        parser.add_argument('--max-turn', type=int, help="Maximum number of iterations", default=None)
        parser.add_argument('--lift-func', type=str, help="Func to be lifted", default="")
        # parser.add_argument('--lift-type', choices=['File', 'Func'], help="Specify the lift type", default='File')
        args = parser.parse_args()

        # if args.lift_type == 'File':
        #     config.lift_type = LiftType.File
        # elif args.lift_type == 'Func':
        #     config.lift_type = LiftType.Func
        # else:
        #     print(f"Unrecognized lift type: {args.lift_type}")
        #     return None

        config.lift_func = args.lift_func
        if not config.lift_func:
            with open(f"{config.test_dir}/scripts/lift_funcs.txt") as f:
                config.lift_func = f.read()

        if not args.max_turn: 
            config.max_turn = 10
        else:
            config.max_turn = args.max_turn
        if args.fix_type == "File":
            config.fix_type = FixType.File
        elif args.fix_type == "Func":
            config.fix_type = FixType.Func
            print("Unsupported fix type: Func")
            return None
        elif args.fix_type == "Line":
            config.fix_type = FixType.Line
        else:
            print(f"Unrecognized fix type: {args.fix_type}")
            return None

        if not os.path.isabs(args.binary) and not os.path.dirname(args.binary):
            binary_path = os.path.join(config.test_dir, config.tmpfile_dir, args.binary)
            config.binary = args.binary.removesuffix(".so")
        else:
            config.binary = os.path.basename(args.binary).removesuffix(".so")
            binary_path = os.path.abspath(args.binary)
            
        if not os.path.isfile(binary_path):
            raise FileNotFoundError(f"file {binary_path} not exist")

        return config


class DataPreprocess:
    def __init__(self, llvm_ir):
        self.llvm_ir = llvm_ir
    
    def fix_call(self):
        call_regex = re.compile(r"(?:(%[\w.]+) = )?call\s+([^\s]+)\s+(.*)")
        unique_counter = 0  # 用于生成独特的 SSA 变量名称

        # 分割输入字符串为行进行逐行处理
        lines = self.llvm_ir.split("\n")
        processed_lines = []

        for line in lines:
            match = call_regex.search(line)
            if match:
                ssa_var, return_type, call_body = match.groups()

                # 如果返回值类型不是 void 且没有赋值给 SSA 变量
                if return_type != "void" and ssa_var is None:
                    print("non-void return-type call doesn't assigned to an SSA variable")
                    print(f"before fix: {line}")
                    # 生成一个唯一的 SSA 变量
                    unique_ssa = f"%call_ssa_{unique_counter}"
                    unique_counter += 1
                    line = f"  {unique_ssa} = call {return_type} {call_body}"
                    print(f"after fix: {line}")
                
                if return_type == "void" and ssa_var:
                    print("void return-type call can't be assigned to an SSA variable")
                    print(f"before fix: {line}")
                    line = f"  call {return_type} {call_body}"
                    print(f"after fix: {line}")

            processed_lines.append(line)

        # 将处理后的行重新组合为一个字符串
        self.llvm_ir = "\n".join(processed_lines)
    
    def fix_format(self):
        lines = self.llvm_ir.splitlines()
        if lines[0] == '```llvm' and lines[-1] == '```':
            print("llvm_ir contains unwanted symbol: ```llvm ...```")
            self.llvm_ir = "\n".join(lines[1:-1]) # 删除第一行与最后一行
        elif lines[0] == '```llvm':
            print("llvm_ir contains unwanted symbol: ```llvm")
            self.llvm_ir = "\n".join(lines[1:])
    
    def get_llvm_str(self):
        return self.llvm_ir

def read_line(file_path, line_number):
    with open(file_path, "r") as file:
        lines = file.readlines()  # 读取所有行
        if 0 < line_number <= len(lines):
            return lines[line_number - 1].strip()  # 返回指定行的内容
    return None  # 如果行号超出文件范围，则返回 None

def is_str(str):
    return True

def get_string_type(str):
    # print(str)
    # print(len(str))
    if not is_str(str): # @todo: how to determine if the reference points to a string?
        return None
    return f"[{len(str) + 1} x i8]" # +1 因为需要LLVM计算字符串长度是需要包括\00
    

def extract_error_line(clang_output):
    # 正则表达式匹配 clang 错误输出中的行号和错误信息
    error_pattern = re.compile(r"^(.*?):(\d+):(\d+):\s*(error|warning):\s*(.*)$")

    # 解析每一行的 clang 输出
    error_lines = []
    for line in clang_output.splitlines():
        match = error_pattern.match(line)
        if match:
            filename = match.group(1)  # 文件名
            line_number = int(match.group(2))  # 错误发生的行号
            column_number = int(match.group(3))  # 列号（如果需要）
            error_type = match.group(4)  # 错误类型
            error_message = match.group(5)  # 错误信息
            error_lines.append(
                (filename, line_number, column_number, error_type, error_message)
            )

    return error_lines


def replace_line_in_file(file_path, line_number, llvm_ir):
    # 读取文件内容到列表
    with open(file_path, "r") as file:
        lines = file.readlines()

    # 检查行号是否有效
    if 0 < line_number <= len(lines):
        # 替换指定行内容
        lines[line_number - 1] = llvm_ir + "\n"
    else:
        print(f"Error: Line number {line_number} is out of range.")
        exit(-1)

    # 将修改后的内容写回文件
    with open(file_path, "w") as file:
        file.writelines(lines)

    print(f"Line {line_number} of {file_path} has been replaced with the new LLVM IR.")


def generate_feedback_prompt(error_type: ErrorType, error_msg: ClangError, fix_type: FixType, llvm_ir: str):
    if error_type == ErrorType.CompileError:
        # save error msg
        # with open(error_msg_save_file + "." + str(turn), "w") as f:
        #     f.write("COMPILE_ERROR\n" + error_msg)
        # print(f"compile failed, error message is:\n {error_msg}")
        # print("extracting error line from error message")
        # error_lines = extract_error_line(error_msg)
        # print(error_lines)
        # file_path, line_number, _, _, error_message = error_lines[0]
        file_path = error_msg.file
        line_number = error_msg.line
        error_lines = read_line(file_path, line_number)
        if error_lines == None:
            print(f"Failed to read line {line_number} from file {file_path}")
            return None
        
        # print(error_lines)

        # generate feedback, using as prompts
        if fix_type == FixType.File:
            feedback_prompts = [
                # prompts: 你生成的LLVM IR有错误，使用llvm-as工具将生成的LLVM汇编码编译成LLVM字节码时报错，报错信息如下：
                # prompts：请重新生成上述x86汇编代码对应的LLVM IR。请遵循之前提出的几点要求。
                                        # Original LLVM IR are as follows: {llvm_ir}\
                {
                    "role": "user",
                    "content": f"""The LLVM IR you generated contains errors. \
                        The content of the line where the error occurred is: {error_lines} \
                        The error message is: {error_msg.message} \
                        Please fix the error. Do not explain anything and include any extra instructions, only print LLVM IR.""",
                },
                # {
                #     "role": "user",
                #     "content": """Please fix the error. \
                #         Do not explain anything and include any extra instructions, only print LLVM IR.""",
                # },
            ]
        elif fix_type == FixType.Line:
            feedback_prompts = [
                {
                    "role": "assistant",
                    "content": f"""The LLVM IR you generated contains errors. \
                        The content of the line where the error occurred is: {error_lines} \
                            The error message is: {error_msg.message}""",
                },
                {
                    "role": "user",
                    "content": """Please fix the error. \
                        Do not explain anything and include any extra instructions, only print LLVM IR of the fixed line.""",
                },
            ]
        else: # Func
            print("Unsupported fix type: Func")
            feedback_prompts = None
    # elif error_type == "link_time":
    #     # save error msg
    #     with open(error_msg_save_file + "." + str(turn), "w") as f:
    #         f.write("LINK_ERROR\n" + error_msg)
    #     print(f"link failed, error message is {error_msg}")
    #     # generate feedback, using as prompts
    #     feedback_prompts = [
    #         # prompts: 你生成的LLVM IR有错误，使用llvm-link工具链接该LLVM字节码文件与其他LLVM字节码文件时报错，报错信息如下:
    #         # prompts：请重新生成上述x86汇编代码对应的LLVM IR。请遵循之前提出的几点要求。
    #         {
    #             "role": "assistant",
    #             "content": "The LLVM IR you generated contains errors. When using the llvm-link tool to link this LLVM bytecode file with other LLVM bytecode files, \
    # 				an error occurred, and the error message is as follows:\n"
    #             + error_msg,
    #         },
    #         {
    #             "role": "user",
    #             "content": "Please regenerate the LLVM IR corresponding to the above x86 assembly code based on the error message. Please follow the previously stated requirements. \
    #                 Your response should contain only the LLVM IR, without any additional content, especially without markdown symbols like ```",
    #         },
    #     ]
    # elif error_type == "run_time":
    #     # save error msg
    #     with open(error_msg_save_file + "." + str(turn), "w") as f:
    #         f.write("RUN_ERROR\n" + error_msg)
    #     print(f"run failed, error message is {error_msg}")
    #     # generate feedback, using as prompts
    #     feedback_prompts = [
    #         # prompts: 你生成的LLVM IR有错误，使用lli工具运行对应的LLVM字节码时出错，报错信息如下:
    #         # prompts：请重新生成上述x86汇编代码对应的LLVM IR。请遵循之前提出的几点要求。
    #         {
    #             "role": "assistant",
    #             "content": "The LLVM IR you generated contains errors. When using the lli tool to run the corresponding LLVM bytecode, \
    # 				an error occurred, and the error message is as follows:\n"
    #             + error_msg,
    #         },
    #         {
    #             "role": "user",
    #             "content": "Please regenerate the LLVM IR corresponding to the above x86 assembly code based on the error message. Please follow the previously stated requirements. \
    #                 Your response should contain only the LLVM IR, without any additional content, especially without markdown symbols like ```",
    #         },
    #     ]
    # elif error_type == "run_result_error":
    #     # save error msg
    #     with open("output.std", "r") as f:
    #         output_std = f.read()

    #     error_msg_output = (
    #         f"your output is:\n{error_msg}\nstandard output is:\n{output_std}"
    #     )
    #     with open(error_msg_save_file + "." + str(turn), "w") as f:
    #         f.write("RESULT_ERROR\n" + error_msg_output)

    #     print("output is inconsistent.\n" + error_msg_output)
    #     # generate feedback, using as prompts
    #     feedback_prompts = [
    #         # prompts: 你生成的LLVM IR有错误，使用lli工具运行对应的LLVM字节码时，你的输出与标准输出不一致，你的输出如下: 标准输出如下:
    #         # prompts：请重新生成上述x86汇编代码对应的LLVM IR。请遵循之前提出的几点要求。
    #         {
    #             "role": "assistant",
    #             "content": "The LLVM IR you generated contains errors. When using the lli tool to run the corresponding LLVM bytecode, \
    # 				your output is inconsistent with the expected standard output."
    #             + error_msg_output,
    #         },
    #         {
    #             "role": "user",
    #             "content": "Please regenerate the LLVM IR corresponding to the above x86 assembly code based on the error message. Please follow the previously stated requirements. \
    #                 Your response should contain only the LLVM IR, without any additional content, especially without markdown symbols like ```",
    #         },
    #     ]
    else:
        print("error type not recognized")

    return feedback_prompts
    # prompts += feedback_prompts
    # return error_lines[0]

def generate_feedback_prompt_v2(error_type: ErrorType, error_msg: ClangError, fix_type: FixType, llvm_ir: str):
    file_path = error_msg.file
    line_number = error_msg.line
    error_lines = read_line(file_path, line_number)
    if error_lines == None:
        print(f"Failed to read line {line_number} from file {file_path}")
        return None
    
    # print(error_lines)

    # generate feedback, using as prompts
    if fix_type == FixType.File:
        feedback_prompts = [
            {
                "role": "user",
                "content": f"""
                    The content of the line where the error occurred is: {error_lines} \
                    The error message is: {error_msg.message} \
                    Please fix the error. Do not explain anything and include any extra instructions, only print LLVM IR.""",
            },
            # {
            #     "role": "user",
            #     "content": """Please fix the error. \
            #         Do not explain anything and include any extra instructions, only print LLVM IR.""",
            # },
        ]
    elif fix_type == FixType.Line:
        feedback_prompts = [
            {
                "role": "assistant",
                "content": f"""The LLVM IR you generated contains errors. \
                    The content of the line where the error occurred is: {error_lines} \
                        The error message is: {error_msg.message}""",
            },
            {
                "role": "user",
                "content": """Please fix the error. \
                    Do not explain anything and include any extra instructions, only print LLVM IR of the fixed line.""",
            },
        ]
    else: # Func
        print("Unsupported fix type: Func")
        feedback_prompts = None
    return feedback_prompts

if __name__ == "__main__":
    clang_error = """/home/hxa/test/openai/tmpfiles/hello_world-llm-dis.ll:24:155: error: '@file' defined with type '[9 x i8]*' but expected '[10 x i8]*'
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @assertion, i32 0, i32 0), i8* getelementptr inbounds ([10 x i8], [10 x i8]* @file, i32 0, i32 0), i32 5, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @function, i32 0, i32 0))"""
    error_lines = extract_error_line(clang_error)
    print(error_lines)
