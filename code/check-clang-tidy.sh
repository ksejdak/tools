#!/bin/bash

set -e

if [ ! -f "compile_commands.json" ]; then
    echo "No 'compile_commands.json' file found. Aborting."
    exit 1
fi

python3 ../tools/code/run-clang-tidy.py -quiet -export-fixes='clang-tidy.warn' -checks='*,
                                                                                       -cppcoreguidelines-pro-type-union-access,
                                                                                       -cppcoreguidelines-pro-type-member-init,
                                                                                       -cppcoreguidelines-pro-bounds-array-to-pointer-decay,
                                                                                       -cppcoreguidelines-pro-bounds-constant-array-index,
                                                                                       -cppcoreguidelines-pro-type-reinterpret-cast,
                                                                                       -cppcoreguidelines-pro-bounds-pointer-arithmetic,
                                                                                       -google-readability-braces-around-statements,
                                                                                       -google-readability-function-size,
                                                                                       -google-build-using-namespace,
                                                                                       -hicpp-braces-around-statements,
                                                                                       -hicpp-no-array-decay,
                                                                                       -hicpp-member-init,
                                                                                       -hicpp-function-size,
                                                                                       -readability-implicit-bool-conversion,
                                                                                       -readability-braces-around-statements,
                                                                                       -readability-redundant-member-init,
                                                                                       -readability-function-size,
                                                                                       -modernize-use-default-member-init,
                                                                                       -fuchsia-statically-constructed-objects' >/dev/null 2>&1
                                                                                       #-fuchsia-default-arguments' >/dev/null 2>&1
