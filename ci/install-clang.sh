#!/bin/bash
# $1 - clang version to be installed (e.g. 3.8.2)
# $2 - Host OS (Linux or macOS)
# $3 - Export CC flag (true/false)

set -ev

VERSION=${1}
OS=${2}
EXPORT=${3}

if [ -z ${VERSION} ]; then
    echo "No clang version specified. Aborting."
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

echo "Installing clang v${VERSION}."

if [ "${OS}" == "linux" ]; then
    PACKAGE_NAME="clang+llvm-${VERSION}-x86_64-linux-gnu-ubuntu-14.04"
    PACKAGE_BIN_NAME="${PACKAGE_NAME}.tar.xz"
    PACKAGE_URL="http://releases.llvm.org/${VERSION}/${PACKAGE_BIN_NAME}"

    wget --no-check-certificate --quiet ${PACKAGE_URL}
    if [ ! -f ${PACKAGE_BIN_NAME} ]; then
        echo "Failed to download clang v${VERSION}."
        exit 3
    fi

    mkdir -p clang
    tar --strip-components=1 -xf ${PACKAGE_BIN_NAME} -C clang

    sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
    sudo apt-get update -qq
    sudo apt-get install libstdc++-8-dev -y

    echo "${PWD}/clang/bin" >> ~/path_exports
else
    MAJOR_VERSION=`echo ${VERSION} | cut -d . -f 1`
    brew install llvm@${MAJOR_VERSION}

    echo "/usr/local/opt/llvm/bin" >> ~/path_exports
fi

SHORT_VERSION=`echo ${VERSION} | cut -d . -f 1-2`
if [ "${EXPORT}" == "true" ]; then
    echo "export CC=clang-${SHORT_VERSION}" >> ~/.bash_profile
    echo "export CXX=clang++" >> ~/.bash_profile
fi

echo "Installing clang v${VERSION} OK."
