#!/bin/bash

set -e

pushd /
pwd
echo "
import sys
import ${PKG_NAME}
code = ${PKG_NAME}.test()
sys.exit(code)
" > test_this.py

ls
chmod 777 test_this.py
chmod +x test_this.py
$1/python test_this.py

rm test_this.py

popd
