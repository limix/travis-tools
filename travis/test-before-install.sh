#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then
    python setup.py test
else
    docker run -e PKG_NAME=${PKG_NAME} -e PY_DEPS="${PY_DEPS}" \
    -e PRJ_NAME="${PRJ_NAME}" -e BGEN="${BGEN}" -e LIKNORM="${LIKNORM}" \
    -e ZSTD="${ZSTD}" \
    --rm -v `pwd`:/io $DOCKER_IMAGE /io/travis/test-before-install-manylinux.sh
fi
