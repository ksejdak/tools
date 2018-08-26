#!/bin/bash
# $1 - Host OS (Linux or macOS)

OS=${1}

if [ -z ${OS} ]; then
    echo "No host OS specified. Aborting."
    exit 1
fi

echo "Installing lcov."

if [ "${OS}" == "linux" ]; then
    sudo apt-get install lcov -y
else
    brew install lcov
fi
echo "Installing lcov OK."
