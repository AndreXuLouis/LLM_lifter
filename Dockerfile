# 基础镜像
FROM ubuntu:22.04.4

# 环境设置
ENV DEBIAN_FRONTEND=noninteractive

# 更新软件源并安装必要工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    libx11-6 \
    libxext6 \
    libxtst6 \
    zlib1g-dev \
    libtinfo-dev \
    software-properties-common \
    librt-dev \
    libpthread-stubs0-dev \
    libstdc++6 \
    libm-dev \
    libc6-dev \
    libgcc-s1 \
    libdl-dev \
    && rm -rf /var/lib/apt/lists/*

# 添加 deadsnakes PPA 并安装 Python 3.10.12
RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update && apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3.10-distutils \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 设置 Python 3.10 为默认 Python 版本
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# 设置工作目录
WORKDIR /work

# 复制 LLM_lifter 项目文件
COPY /home/hxa/LLM_lifter /work/LLM_lifter

# 复制 llvm-project 和 llvm-build 目录
COPY /home/hxa/llvm-project /work/llvm-project
COPY /home/hxa/llvm-build /work/llvm-build

# 复制 IDA Pro 文件夹
COPY /home/hxa/idapro-9.0 /work/idapro-9.0

# 配置环境变量
ENV PATH="/usr/local/bin:/work/llvm-build/bin:$PATH"
ENV LD_LIBRARY_PATH="/usr/local/lib:/work/idapro-9.0:$LD_LIBRARY_PATH"
ENV IDA_DIR="/work/idapro-9.0"

# 安装 Python 依赖
WORKDIR /work/LLM_lifter
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# 设置默认命令
CMD ["bash"]
