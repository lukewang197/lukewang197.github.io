#!/bin/bash

set -e

if [[ $# -lt 1 || -z "$1" ]]; then
	echo "用法: $0 \"提交说明\"" >&2
	exit 64
fi

git add .

if git diff --cached --quiet; then
	echo "没有需要提交的修改"
	exit 0
fi

git commit -m "$1"

if ! git push; then
	echo "远程有新的提交，正在同步后重试..."
	git pull --rebase origin main
	git push
fi