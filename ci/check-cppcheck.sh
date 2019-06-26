#!/bin/bash
# $1 - path to includes
# $2 - path to sources
# $3 - path to reference cppcheck.warn file

INCLUDE_PATH=${1}
SRC_PATH=${2}
REFERENCE_PATH=${3}

if [ -z ${INCLUDE_PATH} ]; then
    echo "No include path specified. Aborting."
    exit 1
fi

if [ -z ${SRC_PATH} ]; then
    echo "No source path specified. Aborting."
    exit 2
fi

if [ -z ${REFERENCE_PATH} ]; then
    echo "No reference cppcheck.warn path specified. Aborting."
    exit 3
fi

OUTPUT=$(tools/code/check-cppcheck.sh ${INCLUDE_PATH} ${SRC_PATH})

if [ -f ${REFERENCE_PATH} ]; then
    while IFS= read -r LINE; do
        RESULT=$(grep -F "${LINE}" "${REFERENCE_PATH}")
        if [ -z "${RESULT}" ]; then
            echo "cppcheck error: '${OUTPUT}'"
            exit 4
        fi
    done < <(printf '%s\n' "${OUTPUT}")
fi

echo "cppcheck check OK."
