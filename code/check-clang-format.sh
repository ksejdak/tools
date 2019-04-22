#!/bin/bash
# $1... - paths to look for source files

set -e

if [ "$#" -eq 0 ]; then
    echo "No source paths specified. Aborting."
    exit 1
fi

CONFIG_FILE=".clang-format"
if [ ! -f ${CONFIG_FILE} ]; then
    echo "No ${CONFIG_FILE} found. Using default one."
    CONFIG_FILE="tools/template/clang-format"
fi

for SRC_PATH in "$@"; do
    find ${SRC_PATH} -iname '*.h' -o -iname '*.hpp' -o -iname '*.cpp' -o -iname '*.c' | xargs clang-format -style=file -assume-filename=${CONFIG_FILE} -fallback-style=none -i
done

exit 0
