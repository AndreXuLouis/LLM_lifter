from typing import List, Dict
import re
import sys
import struct
from LLVMDataType import *

def bytes_to_integers(byte_list, data_type):
    """
    将字节数组解析为指定数据类型的整数列表。

    :param byte_list: 输入的字节数组，每个元素为 0-255 的整数。
    :param data_type: 指定的数据类型，可选值为 1: 'int8', 2: 'int16', 4: 'int32', 8: 'int64'。
    :return: 指定数据类型表示的整数列表，以十六进制格式输出。
    """
    # 定义支持的数据类型及其格式和大小
    type_info = {
        1: ('b', 1),
        2: ('h', 2),
        4: ('i', 4),
        8: ('q', 8),
    }

    if data_type not in type_info:
        raise ValueError(f"不支持的数据类型: {data_type}")

    format_char, size = type_info[data_type]

    # 检查字节数组长度是否为指定类型大小的倍数
    if len(byte_list) % size != 0:
        raise ValueError(f"输入的字节数组长度不是 {data_type} 大小的倍数。")

    # 将字节数组转化为字节流
    byte_data = bytes(byte_list)

    # 使用 struct.unpack 每次读取指定大小的字节
    int_list = struct.unpack(f"<{len(byte_list) // size}{format_char}", byte_data)

    # 转换为十六进制字符串表示
    return int_list


class IDAProConstant:
    def __init__(self, name, type: LLVMDataType, data):
        self.name = name
        self.type = type
        if not self.type.is_string():
            self.data = data
        else: # 对于字符串常量，我们需要将其中的\n显示出来，所以需要使用repr
            self.data = '"' + repr(data)[1:-1] + '"'
    def dump(self, output_file):
        if self.type.is_float(): # 浮点数需要以左对齐64位格式输出
            data_str = f"{self.data:016x}".upper()
            output_file.write(f"{self.name} = {self.type} 0x{data_str}\n")
        else:
            output_file.write(f"{self.name} = {self.type} {self.data}\n")

class IDAProStringConstant(IDAProConstant):
    def __init__(self, name, data):
        super().__init__(name, LLVMString(data), data)

class IDAProGlobalVar:
    def __init__(self, name, type: LLVMDataType, init_data):
        self.name = name
        self.type = type
        self.init_data = init_data
    def dump(self, output_file):
        if self.type.is_ptr():
            if self.init_data:
                assert(len(self.init_data) == 1)
                output_file.write(f"{self.name} = {self.type} offset {self.init_data[0][1]}\n")
            else:
                output_file.write(f"{self.name} = {self.type} zeroinitializer")
        elif self.type.is_float():
            data = bytes_to_integers(self.init_data, self.type.get_size())[0]
            data_str = f"{data:016x}".upper()
            output_file.write(f"{self.name} = {self.type} 0x{data_str}\n")
        elif self.type.is_array():
            output_file.write(f"{self.name} = {self.type} ")
            if self.type.elem_type.is_ptr():
                data_list = [f"offset {e[1]}" for e in self.init_data]
                output_file.write("[" + ", ".join(data_list) + "]\n")
            else:
                if self.init_data:
                    data_list = bytes_to_integers(self.init_data, self.type.get_elem_size())
                    if self.type.elem_type.is_float():
                        data_list = [f"0x{num:x}" for num in data_list]
                    else:
                        data_list = [f"{num}" for num in data_list]
                    output_file.write("[" + ", ".join(data_list) + "]\n")
                else:
                    output_file.write("zeroinitializer\n")
        elif self.type.is_struct():
            print("Unsupported data type: struct")
            output_file.wirte(f"{self.name} = {self.type} {self.init_data}")
        elif self.type.is_int():
            print(f"name = {self.name}, type = {self.type}")
            if self.init_data:
                data = bytes_to_integers(self.init_data, self.type.get_size())[0]
            else:
                data = 0
            output_file.write(f"{self.name} = {self.type} {data}\n")
        else:
            output_file.write(f"{self.name} = {self.type} {self.init_data}\n")


class IDAProExternVar:
    def __init__(self, name, type: LLVMDataType):
        self.name = name
        self.type = type
    def dump(self, output_file):
        output_file.write(f"{self.name}")
        if not self.type.is_unknown():
            output_file.write(f" = {self.type}")
        output_file.write("\n")


class IDAProLabel:
    def __init__(self, name, loc):
        self.name = name
        self.loc = loc
    def dump(self, output_file):
        output_file.write(f"{self.name}:\n")


class IDAProInstruction:
    def __init__(self, opc: str, op_str: str, cmt: str="", label: IDAProLabel=None):
        self.opc = opc
        self.op_str = op_str
        self.cmt = cmt
        self.label = label

    @classmethod
    def from_disasm_string(self, disasm_str):
        pattern = r"^\s*([a-zA-Z0-9]+)\s*(.*)?\s*(;(.*))?$"
        # print(f"disasm_str={disasm_str}")
        match = re.match(pattern, disasm_str)
        op, op_str, cmt = match.group(1), match.group(2), match.group(4)
        return IDAProInstruction(op, op_str, cmt)

    def add_label(self, label: IDAProLabel):
        self.label = label

    def dump(self, output_file):
        if self.label:
            self.label.dump(output_file)
        output_file.write(f"{self.opc:<10} {self.op_str:<}")
        if self.cmt:
            output_file.write(f"; {self.cmt}")
        output_file.write("\n")

    def __str__(self):
        insn_str = ""
        if self.label:
            insn_str += f"{self.label}"
        insn_str += f"{self.opc:<10} {self.op_str:<}"
        if self.cmt:
            insn_str += f"; {self.cmt}"
        return insn_str
            

class IDAProLocalVar:
    def __init__(self, name, size, offset):
        self.name = name
        self.size = size
        self.offset = offset # 相对于rbp指针的偏移

    def dump(self, output_file):
        var_size_str = f"qword ptr" if self.size == 8 \
            else f"dword ptr" if self.size == 4 \
            else f"word ptr" if self.size == 2 \
            else f"byte ptr"
        output_file.write(f"{self.name} = {var_size_str} {self.offset}\n")

class IDAProFunction:
    def __init__(self, name: str):
        self.name = name
        self.locals = []
        self.insns = []
    
    def dump(self, output_file):
        output_file.write(f"{self.name} proc\n")
        if self.locals:
            output_file.write("<local>\n")
            for local in self.locals:
                local.dump(output_file)
            output_file.write("</local>\n")
        if self.insns:
            for insn in self.insns:
                insn.dump(output_file)
        output_file.write(f"{self.name} endp\n")
    
    def add_localvar(self, name, size, offset):
        self.locals.append(IDAProLocalVar(name, size, offset))

    def add_insn(self, disasm_str, label: IDAProLabel=None):
        insn = IDAProInstruction.from_disasm_string(disasm_str)
        if IDAProLabel:
            insn.add_label(label)
        self.insns.append(insn)
    
    # def add_insn(self, opc: str, op_str: str, cmt: str="", label: IDAProLabel=None):
    #     self.insns.append(IDAProInstruction(opc, op_str, cmt, label))

class IDAProDisassembly:
    def __init__(self):
        # Constants
        self.constants = {}

        # Global variables
        self.globals = {}
        
        # External references
        self.externs = {}
        
        # Function lists
        self.functions = []

    def add_constant(self, name, dtype: LLVMDataType, data):
        """Add a constant."""
        self.constants[name] = IDAProConstant(name, dtype, data)

    def add_constants(self, cons_list: List[IDAProConstant]):
        """Add multiple constants."""
        for const in cons_list:
            self.constants[const.name] = const

    def add_globalvar(self, name, dtype, data):
        """Add a global variable."""
        self.globals[name] = IDAProGlobalVar(name, dtype, data)

    def add_globalvars(self, gvars: List[IDAProGlobalVar]):
        """Add multiple global variables."""
        for gvar in gvars:
            self.globals[gvar.name] = gvar

    def add_externvar(self, name, dtype):
        """Add an external reference."""
        self.externs[name] = IDAProExternVar(name, dtype)

    def add_externvars(self, evars: List[IDAProExternVar]):
        """Add multiple external references."""
        for evar in evars:
            self.externs[evar.name] = evar

    def add_function(self, func: IDAProFunction):
        self.functions.append(func)

    # def add_function(self, name, locals: List[IDAProLocalVar]=None, instructions: List[IDAProInstruction]=None):
    #     """Add a function with its local variables and assembly code."""
    #     self.functions.append(IDAProFunction(name, locals, instructions))

    def dump(self, output_file):
        """Print the abstracted disassembly."""
        if self.constants:
            output_file.write("<constant>\n")
            for cons in self.constants.values():
                cons.dump(output_file)
            output_file.write("</constant>\n")

        if self.globals:
            output_file.write("<global>\n")
            for globalvar in self.globals.values():
                globalvar.dump(output_file)
            output_file.write("</global>\n")    

        if self.externs:
            output_file.write("<extern>\n")
            for extvar in self.externs.values():
                extvar.dump(output_file)
            output_file.write("</extern>\n")  

        if self.functions:
            for func in self.functions:
                output_file.write("<func>\n")
                func.dump(output_file)
                output_file.write("</func>\n")  


if __name__ == '__main__':
    bytes_list = [164, 6, 64, 0, 171, 6, 64, 0, 176, 6, 64, 0, 0, 0, 0, 0]
    int_list = bytes_to_integers(bytes_list, 'int32')
    print([f"0x{num:x}" for num in int_list])

    disassembly_output = IDAProDisassembly()
    disassembly_output.add_constant("d_cons", LLVMFloat(8), 0x400921FB54442D18)
    disassembly_output.add_constant("i_cons", LLVMInteger(4), 1)
    string = "Double Equal\n"
    disassembly_output.add_constant("s_cons", LLVMString(string), string)

    disassembly_output.add_globalvar("d_glb", LLVMFloat(4), 0x400921FB60000000)
    disassembly_output.add_globalvar("i_glb", LLVMInteger(8), "0")

    disassembly_output.add_externvar("stdout", LLVMPtr())

    func = IDAProFunction("main")
    func.add_localvar("var_14", 4, -20)
    func.add_localvar("var_10", 8, -16)
    func.add_localvar("var_4", 4, -4)

    func.add_insn("push   rbp")
    func.add_insn("mov     [rbp+var_4], 0")
    func.add_insn("jnz     loc_40118C; this is a comment")
    func.add_insn("mov     rdi, offset format", IDAProLabel("label_1", 0x40118c))

    disassembly_output.add_function(func)
    disassembly_output.dump(sys.stdout)