#!/bin/bash
set -e -x

PYBIN="$1"

pushd /
$PYBIN -c "import sys; import ${PKG_NAME}; sys.exit(${PKG_NAME}.test())"
popd
