#!/bin/bash
set -e -x

BIN="$1"

"${BIN}pip" install pytest pytest-pep8 -q

pushd /
"${BIN}python" -c "import sys; import ${PKG_NAME}; sys.exit(${PKG_NAME}.test())"
popd
