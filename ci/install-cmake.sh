#!/bin/bash
# $1 - CMake version to be installed (e.g. 3.8.2)
# $2 - Host OS (Linux or macOS)

set -e

VERSION=${1}
if [ "${2}" == "linux" ]; then
    OS="Linux"
elif [ "${2}" == "osx" ]; then
    OS="Darwin"
fi

if [ -z ${VERSION} ]; then
    echo "No CMake version specified. Aborting."
    exit 1
fi

if [ -z ${OS} ]; then
    echo "No host OS specified. Aborting."
    exit 2
fi

if [ -d cmake ]; then
    exit 0
fi

echo "Installing CMake v${VERSION}."

SHORT_VERSION=$(echo ${VERSION} | cut -d . -f 1-2)
PACKAGE_NAME="cmake-${VERSION}-${OS}-x86_64"
PACKAGE_BIN_NAME="${PACKAGE_NAME}.tar.gz"
PACKAGE_URL="https://cmake.org/files/v${SHORT_VERSION}/${PACKAGE_BIN_NAME}"

wget --no-check-certificate --quiet ${PACKAGE_URL}
if [ ! -f ${PACKAGE_BIN_NAME} ]; then
    echo "Failed to download CMake v${VERSION}."
    exit 3
fi

mkdir -p cmake
tar --strip-components=1 -xf ${PACKAGE_BIN_NAME} -C cmake

if [ "${OS}" == "Linux" ]; then
    echo "${PWD}/cmake/bin" >> ~/path_exports
else
    echo "${PWD}/cmake/CMake.app/Contents/bin" >> ~/path_exports
fi

echo "Installing CMake v${VERSION} OK."
