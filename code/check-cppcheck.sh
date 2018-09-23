#!/bin/bash
# $1 - path to includes
# $2 - path to sources

set -e

INCLUDE_PATH=${1}
SRC_PATH=${2}

if [ -z ${INCLUDE_PATH} ]; then
    echo "No include path specified. Aborting."
    exit 1
fi

if [ -z ${SRC_PATH} ]; then
    echo "No source path specified. Aborting."
    exit 2
fi

cppcheck --quiet -I ${INCLUDE_PATH} --language=c++ --enable=warning,performance,portability,missingInclude ${SRC_PATH} 2>&1
