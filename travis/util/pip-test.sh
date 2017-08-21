#!/bin/bash

set -e

pushd /

$1/python -c "
import sys;
import ${PKG_NAME};
code = ${PKG_NAME}.test();
sys.exit(code)
"

popd
