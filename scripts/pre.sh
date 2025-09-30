#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: ./pre.sh testcase_name"
else
    python3 scripts/file_prep.py testcases/$1 tmpfiles/$1
fi