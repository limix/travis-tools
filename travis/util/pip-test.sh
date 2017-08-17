#!/bin/bash
set -e

$1/python -c "import sys; import ${PKG_NAME}; sys.exit(${PKG_NAME}.test())"
