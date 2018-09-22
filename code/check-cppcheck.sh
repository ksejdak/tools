#!/bin/bash
# $1 - path to includes
# $2 - path to sources

set -e

if [ -z ${1} ]; then
    echo "No include path specified. Aborting."
    exit 1
fi

if [ -z ${2} ]; then
    echo "No source path specified. Aborting."
    exit 2
fi

cppcheck --quiet -I ${1} --language=c++ --enable=warning,performance,portability,missingInclude ${2} 2>&1
