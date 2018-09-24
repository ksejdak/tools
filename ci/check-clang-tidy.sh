#!/bin/bash
# $1 - build path

BUILD_PATH=${1}

if [ -z ${BUILD_PATH} ]; then
    echo "No build path specified. Aborting."
    exit 1
fi

cd ${BUILD_PATH}

echo "========="
echo $PWD
tools/code/check-clang-tidy.sh
CLANG_CHECK_ERR=$?

cd -

if [ ${CLANG_CHECK_ERR} -ne 0 ]; then
    echo "Failed to run check-clang-tidy.sh script."
    exit 2
fi

echo "clang-tidy check OK."
