#!/bin/bash
set -e
cd "${0%/*}"
for file in *.mic
do
    ./mic.py "$file" --v3hex > "${file%.*}.v3hex"
done
