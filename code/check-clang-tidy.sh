#!/bin/bash

set -e

if [ ! -f "compile_commands.json" ]; then
    echo "No 'compile_commands.json' file found. Aborting."
    exit 1
fi

echo "++++++++++++++"
python ../tools/code/run-clang-tidy.py -checks=*
