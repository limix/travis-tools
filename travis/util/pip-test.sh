#!/bin/bash

set -e

pushd /
echo "
import sys
import ${PKG_NAME}
code = ${PKG_NAME}.test()
sys.exit(code)
" > test_this.py

$1/python test_this.py

rm test_this.py

popd
