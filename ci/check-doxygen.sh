#!/bin/bash
# $1 - path to generated doxygen.warn file during build
# $2 - path to reference doxygen.warn file

GENERATED_PATH=${1}
REFERENCE_PATH=${2}

if [ -z ${GENERATED_PATH} ]; then
    echo "No generated doxygen.warn file specified. Aborting."
    exit 1
fi

if [ -z ${REFERENCE_PATH} ]; then
    echo "No reference doxygen.warn file specified. Aborting."
    exit 2
fi

if [ -f ${GENERATED_PATH} ]; then
    while IFS='' read -r LINE || [[ -n "$LINE" ]]; do
        WARN=${LINE#"${PWD}/"}
        RESULT=$(grep "${WARN}" "${REFERENCE_PATH}")
        if [ -z "${RESULT}" ]; then
            echo "Doxygen warning: '${LINE}'"
            exit 3
        fi

    done < ${GENERATED_PATH}
fi

echo "Doxygen check OK."
