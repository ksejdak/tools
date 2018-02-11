#!/bin/bash
# $1 - path to look for source files

if [ -z ${1} ]; then
    echo "No source path specified. Aborting."
    exit 1
fi

CONFIG_FILE=".clang_format"
if [ ! -f ${CONFIG_FILE} ]; then
    echo "No ${CONFIG_FILE} found. Using default one."
    CONFIG_FILE="tools/code/clang_format"
fi

find ${1} -iname '*.h' -o -iname '*.cpp' -o -iname '*.c' | xargs clang-format -style=file -assume-filename=${CONFIG_FILE} -fallback-style=none -i
