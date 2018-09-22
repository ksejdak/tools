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

OUTPUT=`tools/code/check-cppcheck.sh ${1} ${2}`
INVALID_LINES=`echo "${OUTPUT}" | wc -l | xargs`
if [ ${INVALID_LINES} -ne 0 ]; then
    echo "cppcheck.sh found ${INVALID_LINES} issues:"
    echo ${OUTPUT}
    exit 3
fi

echo "cppcheck check OK."
