# LLM_lifter - 大模型辅助的二进制提升器

## 架构图示意
LLM_lifter主要由四个模块组成：反汇编模块，生成模块，验证模块，纠错模块
<img width="897" height="562" alt="image" src="https://github.com/user-attachments/assets/3db85dd0-51ac-4bba-bb3a-b8b3b520ef3e" />

## 测试

### 需要的组件

llvm-mctoll / llvm-lit / FileCheck: 照[此网址](https://github.com/microsoft/llvm-mctoll)步骤依次构建即可

ida pro 9.0

openai API访问权限

### 测试文件夹结构

主要文件夹含义如下：

**err_msgs/**: 自修正时由llvm工具链产生的报错信息。命名格式为`{binary}.{turn}.err`，表示在提升二进制文件\<binary\>时，第\<turn\>轮自修正中的报错信息；

**gpt_functions/**：自修正过程中大模型的回答。命名格式为`{binary}-llm-dis.{turn}.ll`, 表示提升二进制文件\<binary\>时，在第\<turn\>轮自修正中大模型的回答，turn = 0表示大模型生成的初始回答；

**prompts/**：自修正过程中根据报错信息编写的提示词，用于大模型修正自己的结果，以json格式存储。命名格式为`{binary}.pmt.{turn}.json`，表示提升二进制文件\<binary\>时，第\<turn\>轮自修正时给大模型的提示词；

**tmpfiles/Output**：提升过程产生的临时文件，包括二进制文件，反汇编结果（以`.x86_asm`结尾的文件），提升结果（以`-llm-dis.ll`结尾的文件）等文件。（目前为了适应llvm-lit工具的输出位置，将临时文件的输出位置改成了tmpfiles/Output）

**scripts/**：相关脚本，主要包括用于提升二进制汇编的`LLM_lifter.py`，以及ida反汇编脚本`ida_extract_function_asm.py`

**testcases/**：llvm-mctoll的测试集，[github仓库](https://github.com/microsoft/llvm-mctoll/tree/master/test/smoke_test)

**iter_times/**：成功提升（指提升结果能够成功编译，但运行结果不一定正确）时的自修正迭代轮数。命名格式为`{binary}.iter`，表明成功提升\<binary\>时，自修正迭代的次数

### 测试集说明

测试集来自于[llvm-mctoll](https://github.com/microsoft/llvm-mctoll)提升工具的测试集。该测试集利用[llvm-lit](https://llvm.org/docs/CommandGuide/lit.html)测试框架进行测试，testcases目录下每个.c文件中的RUN & CHECK命令即为llvm-lit框架的测试流程。

下面是一个简单的利用llvm-lit框架测试的例子（testcases/hello.c）:
```C
// REQUIRES: system-linux
// RUN: clang -o %t %s
// RUN: llvm-mctoll -d -I /usr/include/stdio.h %t
// RUN: clang -o %t1 %t-dis.ll
// RUN: %t1 2>&1 | FileCheck %s
// CHECK: Hello world!

#include <stdio.h>
int main(int argc, char **argv) {
  printf("Hello world!\n");
  return 0;
}
```

其中以`RUN`开头的行是llvm-lit测试框架测试时需要依次运行的命令，以`CHECK`开头的行则是[FileCheck](https://llvm.org/docs/CommandGuide/FileCheck.html)工具需要检查的内容。

其中`%s`会在使用llvm-lit工具时被替换成源代码路径（如`/path/to/dir/testcases/hello.c`），`%t`和`%t1`会被替换成临时文件名（如`/path/to/dir/testcases/Output/hello.c.tmp`）。

以下测试流程参照llvm-lit测试框架的流程。

### 测试流程

#### 简略测试流程1

简略测试流程：直接运行scripts/run_test.sh脚本即可。
```shell
cd LLM_lifter
source scripts/set_api_key.sh
source scripts/run_test.sh assert.c
```

#### 简略测试流程2

使用llvm-lit工具测试，llvm-lit工具的共建参照[此网址](https://github.com/microsoft/llvm-mctoll).
```shell
cd LLM_lifter
source scripts/set_api_key.sh
# 将测试集原文件中使用llvm-mctoll的测试 改成 使用LLM_lifter的测试
python3 scripts/file_prep.py testcases/assert.c tmpfiles/assert.c
# -a表示显示所有输出，包括stdout与stderr
llvm-lit -a tmpfiles/assert.c
```

#### 详细测试流程

1. 进入工作目录，初始化OPENAI_API_KEY
```shell
cd LLM_lifter
export OPENAI_API_KEY=...
```

2. 编译testcases目录下的文件，假设这里的文件名字为A.c，输出文件名字为A.c.tmp
```shell
clang -o tmpfiles/A.c.tmp testcases/A.c
```
注：编译选项参考testcases/A.c中指定的编译选项，输出文件命名格式参照llvm-lit测试框架命名格式，即如果编译选项中开启了高优化等级（如-O2），则将输出文件命名为A.c.tmp-opt，否则命名为A.c.tmp

3. 用idapro反汇编二进制文件，反汇编结果存入tmpfiles/A.c.tmp.x86_asm中
```shell
/path/to/idapro-9.0/idat64 -A -S"scripts/ida_extract_function_asm.py tmpfiles/A.c.tmp tmpfiles/A.c.tmp.x86_asm" tmpfiles/A.c.tmp
```

4. 使用大模型提升器脚本提升二进制文件，提升结果存放在tmpfiles/A.c.tmp-llm-dis.ll中
```shell
python3 scripts/LLM_lifter.py [--fix-type=File/Func/Line] [--max-turn=N] A.c.tmp
```
注1：参数中传入的二进制文件默认从tmpfiles文件夹下寻找

注2：目前该提升脚本支持文件粒度与行粒度的自修正（对应`File/Line`），不支持函数粒度的自修正（对应`Func`），默认为文件粒度的自修正，可在命令行中通过参数`--fix-type=<FIX_TYPE>`指定

注3：可在命令行通过`--max-turn=N`参数指定自修正轮次，默认为10次

5. 验证提升结果的正确性
```shell
clang -o tmpfiles/A.c.tmp-llm-dis tmpfiles/A.c.tmp-llm-dis.ll
./tmpfiles/A.c.tmp-llm-dis
```

