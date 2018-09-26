#!/bin/bash
# $1 - path to look for source files

SRC_PATH=${1}

if [ -z ${SRC_PATH} ]; then
    echo "No source path specified. Aborting."
    exit 1
fi

tools/code/check-clang-format.sh ${SRC_PATH}
if [ ${?} -ne 0 ]; then
    echo "Failed to run check-clang-format.sh script."
    exit 2
fi

git diff-index --quiet HEAD
if [ ${?} -ne 0 ]; then
    echo "Bad source code format detected for the following files:"
    git diff-index --name-status HEAD
    exit 3
fi

echo "Clang-format check OK."
