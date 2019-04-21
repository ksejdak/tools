#!/bin/bash
# $1 - path to look for source files

set -e

SRC_PATH=${1}

if [ -z ${SRC_PATH} ]; then
    echo "No source path specified. Aborting."
    exit 1
fi

CONFIG_FILE=".clang-format"
if [ ! -f ${CONFIG_FILE} ]; then
    echo "No ${CONFIG_FILE} found. Using default one."
    CONFIG_FILE="tools/template/clang-format"
fi

find ${SRC_PATH} -iname '*.h' -o -iname '*.hpp' -o -iname '*.cpp' -o -iname '*.c' | xargs clang-format -style=file -assume-filename=${CONFIG_FILE} -fallback-style=none -i
