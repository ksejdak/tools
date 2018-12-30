#!/bin/bash
# $1 - Host OS (Linux or macOS)

set -e

OS=${1}

if [ -z ${OS} ]; then
    echo "No host OS specified. Aborting."
    exit 1
fi

echo "Installing cppcheck."

if [ "${OS}" == "linux" ]; then
    sudo apt-get update
    sudo apt-get install cppcheck -y
else
    brew install cppcheck
fi
echo "Installing cppcheck OK."
