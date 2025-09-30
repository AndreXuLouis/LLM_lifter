from enum import Enum, auto
from typing import List
import struct

# 获取当前平台的指针大小
def get_ptr_size():
    return struct.calcsize("P")

class LLVMDataTypeEnum(Enum):
    Unknown = auto()
    Int = auto()
    Float = auto()
    Ptr = auto()
    Array = auto()
    Struct = auto()
    String = auto()

class LLVMDataType:
    def __init__(self, dtype: LLVMDataTypeEnum, size):
        self.dtype = dtype
        self.size = size
    def __str__(self):
        return f"type = {self.dtype}, size = {self.size}"
    def get_size(self):
        return self.size
    def get_elem_size(self):
        return -1
    def dump(self):
        print(self)
    
    def is_unknown(self):
        return self.dtype == LLVMDataTypeEnum.Unknown
    def is_int(self):
        return self.dtype == LLVMDataTypeEnum.Int
    def is_float(self):
        return self.dtype == LLVMDataTypeEnum.Float
    def is_ptr(self):
        return self.dtype == LLVMDataTypeEnum.Ptr
    def is_array(self):
        return self.dtype == LLVMDataTypeEnum.Array or self.dtype == LLVMDataTypeEnum.String
    def is_struct(self):
        return self.dtype == LLVMDataTypeEnum.Struct
    def is_string(self):
        return self.dtype == LLVMDataTypeEnum.String
    def is_primitive_type(self):
        return self.is_int() or self.is_float() or self.is_ptr()
    def is_aggregate_type(self):
        return self.is_array() or self.is_struct() or self.is_string()
    
    def has_ptr(self):
        return self.is_ptr() or (self.is_array() and self.elem_type.is_ptr())

class LLVMUnknown(LLVMDataType):
    def __init__(self):
        self.dtype = LLVMDataTypeEnum.Unknown
        self.size = 0
    def __str__(self):
        return "Unknown type"
    def dump(self):
        print("Unknown Type")

class LLVMInteger(LLVMDataType):
    def __init__(self, size):
        self.dtype = LLVMDataTypeEnum.Int
        self.size = size
        if size != 1 and size != 2 and size != 4 and size != 8:
            raise ValueError(f"Unsupported Data Type with dtype = {self.dtype}, size = {self.size} bytes")
    def __str__(self):
        if self.size != 1 and self.size != 2 and self.size != 4 and self.size != 8:
            raise ValueError(f"Unsupported Data Type with dtype = {self.dtype}, size = {self.size} bytes")
        return f"i{self.size * 8}"
    
class LLVMFloat(LLVMDataType):
    def __init__(self, size):
        self.dtype = LLVMDataTypeEnum.Float
        self.size = size
        if size != 4 and size != 8:
            raise ValueError(f"Unsupported Data Type with dtype = {self.dtype}, size = {self.size} bytes")
    def __str__(self):
        if self.size == 4:
            return "float"
        elif self.size == 8:
            return "double"
        else:
            raise ValueError(f"Unsupported Data Type with dtype = {self.dtype}, size = {self.size} bytes")

class LLVMPtr(LLVMDataType):
    def __init__(self, pointee_type: LLVMDataType = LLVMUnknown()):
        self.dtype = LLVMDataTypeEnum.Ptr
        self.size = get_ptr_size()
        self.pointee_type = pointee_type
    def __str__(self):
        if self.pointee_type.dtype == LLVMDataTypeEnum.Unknown:
            return "Unknown type ptr"
        else:
            return f"{self.pointee_type}*"

class LLVMArray(LLVMDataType):
    def __init__(self, elem_num, elem_type: LLVMDataType):
        self.dtype = LLVMDataTypeEnum.Array
        self.elem_num = elem_num
        if elem_num <= 0:
            raise ValueError(f"The number of elements in Array Data Type cannot be negative")
        self.elem_type = elem_type
        self.size = elem_num * elem_type.get_size()
    def get_elem_size(self):
        return self.elem_type.get_size()
    def __str__(self):
        return f"[{self.elem_num} x {self.elem_type}]"

class LLVMString(LLVMArray):
    def __init__(self, data_str):
        LLVMArray.__init__(self,
                           len(data_str) + 1, 
                           LLVMInteger(1))
        self.dtype = LLVMDataTypeEnum.String

class LLVMStruct(LLVMDataType):
    def __init__(self, elems: List[LLVMDataType]=[]):
        self.dtype = LLVMDataTypeEnum.Struct
        self.elem_list = elems
    def add_elem(self, elem: LLVMDataType):
        self.elem_list.append(elem)
    def __str__(self):
        type_str = "type { "
        type_str += ", ".join(map(lambda x: str(x), self.elem_list))
        type_str += " }"
        return type_str
    def get_size(self):
        total_size = 0
        for elem in self.elem_list:
            total_size += elem.get_size()
        return total_size

if __name__ == '__main__':
    a = LLVMInteger(8)
    # a_err = LLVMInteger(9)
    b = LLVMFloat(4)
    c = LLVMFloat(8)
    d = LLVMPtr(LLVMInteger(4))
    e = LLVMArray(5, LLVMArray(3, LLVMInteger(4)))
    f = LLVMPtr(e)
    g = LLVMString("hello")
    i = LLVMPtr()
    struct = LLVMStruct()
    struct.add_elem(a)
    struct.add_elem(b)
    struct.add_elem(i)
    struct.add_elem(e)

    a.dump()
    b.dump()
    c.dump()
    d.dump()
    e.dump()
    f.dump()
    g.dump()
    i.dump()
    i.dump()
    struct.dump()

    print(f"a.size = {a.get_size()}")
    print(f"b.size = {b.get_size()}")
    print(f"c.size = {c.get_size()}")
    print(f"d.size = {d.get_size()}")
    print(f"e.size = {e.get_size()}")
    print(f"f.size = {f.get_size()}")
    print(f"g.size = {g.get_size()}")
    print(f"i.size = {i.get_size()}")
    print(f"struct.size = {struct.get_size()}")