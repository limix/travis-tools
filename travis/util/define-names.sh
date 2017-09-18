#!/bin/bash

if [ -z "${PRJ_NAME}" ]; then
    PRJ_NAME="$(basename `git rev-parse --show-toplevel`)"
    PRJ_NAME="$(echo $PRJ_NAME | tr _ -)"
fi

if [ -z "${PKG_NAME}" ]; then
    PKG_NAME="$(echo $PRJ_NAME | tr - _)"
fi

export PRJ_NAME
export PKG_NAME

echo "
PKG_NAME=${PKG_NAME}
PRJ_NAME=${PRJ_NAME}
BGEN=${BGEN}
LIKNORM=${LIKNORM}
HCEPHES=${HCEPHES}
ZSTD=${ZSTD}
" > ~/env.list
