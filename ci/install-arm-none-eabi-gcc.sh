#!/bin/bash
# $1 - arm-none-eabi-gcc version to be installed (e.g. 7)
# $2 - Host OS (Linux or macOS)
# $3 - Export CC flag (true/false)

set -e

VERSION=${1}
if [ "${2}" == "linux" ]; then
    OS="linux"
elif [ "${2}" == "osx" ]; then
    OS="mac"
fi
EXPORT=${3}

if [ -z ${VERSION} ]; then
    echo "No arm-none-eabi-gcc version specified. Aborting."
    exit 1
fi

if [ -z ${OS} ]; then
    echo "No host OS specified. Aborting."
    exit 2
fi

if [ -z ${EXPORT} ]; then
    echo "No export CC flag specified. Using 'true' by default."
    EXPORT=true
fi

if [ -d arm-none-eabi-gcc ]; then
    exit 0
fi

echo "Installing arm-none-eabi-gcc v${VERSION}."

case "${VERSION}" in
    "7")
        PACKAGE_NAME="gcc-arm-none-eabi-7-2018-q2-update"
        PACKAGE_BIN_NAME="${PACKAGE_NAME}-${OS}.tar.bz2"
        if [ "${OS}" == "linux" ]; then
            PACKAGE_URL="https://bit.ly/2KYUqcF"
        else
            PACKAGE_URL="https://bit.ly/2R687uJ"
        fi
        ;;
    "8")
        PACKAGE_NAME="gcc-arm-none-eabi-8-2018-q4-major"
        PACKAGE_BIN_NAME="${PACKAGE_NAME}-${OS}.tar.bz2"
        if [ "${OS}" == "linux" ]; then
            PACKAGE_URL="https://bit.ly/2TkzX6W"
        else
            PACKAGE_URL="https://bit.ly/2LFuzIK"
        fi
        ;;
    *)
        echo "Unsupported arm-none-eabi-gcc version."
        exit 3
        ;;

esac

wget --no-check-certificate --quiet ${PACKAGE_URL} -O ${PACKAGE_BIN_NAME}
if [ ! -f ${PACKAGE_BIN_NAME} ]; then
    echo "Failed to download arm-none-eabi-gcc v${VERSION}."
    exit 4
fi

mkdir -p arm-none-eabi-gcc
tar --strip-components=1 -xf ${PACKAGE_BIN_NAME} -C arm-none-eabi-gcc

if [ "${EXPORT}" == "true" ]; then
    echo "export CC=arm-none-eabi-gcc" >> ~/.bash_profile
    echo "export CXX=arm-none-eabi-g++" >> ~/.bash_profile
fi

echo "${PWD}/arm-none-eabi-gcc/bin" >> ~/path_exports

echo "Installing arm-none-eabi-gcc v${VERSION} OK."
