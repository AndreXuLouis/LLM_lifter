#!/bin/bash

# 检查是否提供了参数
if [ -z "$1" ]; then
  echo "Usage: $0 <name>"
  exit 1
fi

# 获取脚本参数
name="$1"

# 获取当前目录的父目录路径
parent_dir=$(dirname "$(pwd)")

# 设置 testcases 文件夹路径
testcases_dir="./testcases"

# 检查 testcases 目录是否存在
if [ ! -d "$testcases_dir" ]; then
  echo "Error: 'testcases' directory does not exist!"
  exit 1
fi

# 创建error_data目录，如果它不存在的话
mkdir -p "$parent_dir/error_data"


if ! find "$testcases_dir" -type f -name "$name" | grep -q .; then
  echo "Error: No file named '$name' found in the 'testcases' directory!"
  exit 1
else
  echo "File '$name' exists in the 'testcases' directory."
fi

# 查找当前目录下包含$name且以.iter结尾的文件，并提取其中的数字
number=10
iter_file=$(find . -type f -name "*$name*.iter" | head -n 1)

if [ -n "$iter_file" ]; then
  # 假设.iter文件中只有一个数字，并且它在第一行
  number=$(head -n 1 "$iter_file")
  echo "Found number $number in the .iter file: $iter_file"
else
  echo "Warning: No .iter file found for '$name'. Using default number: $number"
fi

# 标志，表示是否找到符合条件的文件
error_file_list="error_file_list"

find . -type f -name "*$name*" | while read file; do
  # 获取文件名中的数字（如果存在）
  base_filename=$(basename "$file")
  file_number=$(echo "$base_filename" | grep -oP '\.\d+' | tr -d '.')

  # 如果文件名中没有数字，或者文件名中的数字小于等于iter文件中的number，则进行复制
  if [ -z "$file_number" ] || [ "$file_number" -le "$number" ]; then
    echo "$file" >> $error_file_list
  fi
done

echo "All files name containing '$name' have been recorded in $error_file_list"