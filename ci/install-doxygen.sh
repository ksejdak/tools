#!/bin/bash
# $1 - doxygen version to be installed (e.g. 3.8.2)
# $2 - Host OS (Linux or macOS)

set -ev

VERSION=${1}
OS=${2}

if [ -z ${VERSION} ]; then
    echo "No doxygen version specified. Aborting."
    exit 1
fi

if [ -z ${OS} ]; then
    echo "No host OS specified. Aborting."
    exit 2
fi

if [ -d doxygen ]; then
    exit 0
fi

echo "Installing doxygen v${VERSION}."

if [ "${OS}" == "linux" ]; then
    PACKAGE_BIN_NAME="doxygen-${VERSION}.linux.bin.tar.gz"
else
    PACKAGE_BIN_NAME="Doxygen-${VERSION}.dmg"
fi
PACKAGE_URL="ftp://ftp.stack.nl/pub/users/dimitri/${PACKAGE_BIN_NAME}"

wget --no-check-certificate --quiet ${PACKAGE_URL}
if [ ! -f ${PACKAGE_BIN_NAME} ]; then
    echo "Failed to download doxygen v${VERSION}."
    exit 3
fi

mkdir -p doxygen

if [ "${OS}" == "linux" ]; then
    sudo apt-get install libclang-6.0-dev -y graphviz

    tar --strip-components=1 -xf ${PACKAGE_BIN_NAME} -C doxygen
    echo "${PWD}/doxygen/bin" >> ~/path_exports
else
    brew install graphviz

    hdiutil attach ${PACKAGE_BIN_NAME}
    cp -R /Volumes/Doxygen/* doxygen/
    hdiutil unmount /Volumes/Doxygen
    echo "${PWD}/doxygen/Doxygen.app/Contents/Resources" >> ~/path_exports
fi

echo "Installing doxygen v${VERSION} OK."
