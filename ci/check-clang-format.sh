#!/bin/bash
# $1... - paths to look for source files

if [ "$#" -eq 0 ]; then
    echo "No source paths specified. Aborting."
    exit 1
fi

tools/code/check-clang-format.sh "$@"
if [ ${?} -ne 0 ]; then
    echo "Failed to run check-clang-format.sh script."
    exit 2
fi

git diff-index --quiet HEAD
DIFF_RESULT=${?}
if [ ${DIFF_RESULT} -ne 0 ]; then
    echo "The following bad source code format was detected:"
    git --no-pager diff
    exit 3
fi

echo "Clang-format check OK."
