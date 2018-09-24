#!/bin/bash
# $1 - build path

BUILD_PATH=${1}

if [ -z ${BUILD_PATH} ]; then
    echo "No build path specified. Aborting."
    exit 1
fi

cd ${BUILD_PATH}

GENERATED_WARN_PATH="clang-tidy.warn"
if [ -f ${GENERATED_WARN_PATH} ]; then
    rm ${GENERATED_WARN_PATH}
fi

../tools/code/check-clang-tidy.sh
CLANG_CHECK_ERR=$?

cd -

if [ ${CLANG_CHECK_ERR} -ne 0 ]; then
    echo "Failed to run check-clang-tidy.sh script."
    exit 2
fi

if [ -s ${BUILD_PATH}/${GENERATED_WARN_PATH} ]; then
    echo "Clang-tidy found some issues:"
    cat ${BUILD_PATH}/${GENERATED_WARN_PATH}
    exit 3
fi

echo "Clang-tidy check OK."
