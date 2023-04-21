#! /usr/local/bin/bash

results=$(git log --pretty="tformat:%an" | uniq -c | sed -E)

if [[ $# -lt 1 ]]; then
	echo "Insert valid git repostory !!"
	exit 1
fi

OLDIFS=$IFS
IFS='\'
for line in ${results}; do
    echo "$line"
done
IFS=$OLDIFS