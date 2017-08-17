#!/bin/bash
set -e

BIN="$1"

pushd /
"${BIN}python" -c "import sys; import ${PKG_NAME}; sys.exit(${PKG_NAME}.test())"
popd
