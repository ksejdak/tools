#!/bin/bash
# $1 - path to reference doxygen.warn file
# $2 - path to generated doxygen.warn file during build

set -ev

if [ -z ${1} ]; then
    echo "No reference doxygen.warn file specified. Aborting."
    exit 1
fi

if [ -z ${2} ]; then
    echo "No generated doxygen.warn file specified. Aborting."
    exit 2
fi

while IFS='' read -r LINE || [[ -n "$LINE" ]]; do
    WARN=${LINE#"${PWD}/"}
    RESULT=`grep "${WARN}" "${1}"`
    if [ -z "${RESULT}" ]; then
        echo "Doxygen warning: '${LINE}'"
        exit 3
    fi

done < ${2}

echo "Doxygen check OK."
