#!/bin/bash
# $1 - Host OS (Linux or macOS)

set -ev

OS=${1}

if [ -z ${OS} ]; then
    echo "No host OS specified. Aborting."
    exit 1
fi

echo "Installing doxygen"

if [ "${OS}" == "linux" ]; then
    sudo apt-get install doxygen -y
else
    brew install doxygen
fi

echo "Installing doxygen OK."
