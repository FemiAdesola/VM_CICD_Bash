#! /usr/local/bin/bash

if [ $# -lt 1 ]; then
    echo "Enter the directory as first argument followed by Component name"
    exit 1
fi

while [ $# -gt 0 ]; do
    sum=0
    component=$1
    files=$(find . -name "$component")
for name in $files; do
    sum=$((sum + 1))
done
echo "$component = $sum"
    shift
done

