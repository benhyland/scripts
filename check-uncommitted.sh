#!/bin/sh
UNCOMMITTED_FILE_COUNT=`git status --porcelain | wc -l`

if [ ${UNCOMMITTED_FILE_COUNT} != 0 ]; then
    echo Uncommitted files found
    #git status --porcelain
    exit 1
fi

