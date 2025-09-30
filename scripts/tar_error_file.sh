#!/bin/bash

# 检查是否提供了压缩包的名字
if [ $# -ne 1 ]; then
    echo "Usage: $0 <output-tar.gz>"
    exit 1
fi

# 获取压缩包名字
output_tar="$1"

# 检查 error_file_list 是否存在
if [ ! -f "error_file_list" ]; then
    echo "Error: file 'error_file_list' not found."
    exit 1
fi

# 读取文件列表并打包
tar -czf "$output_tar" -T error_file_list

# 检查打包结果
if [ $? -eq 0 ]; then
    echo "Files successfully packed into $output_tar"
else
    echo "Failed to create the archive."
    exit 1
fi
