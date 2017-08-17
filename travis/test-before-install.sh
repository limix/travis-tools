#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then
    pip install -U -r requirements.txt -r test-requirements.txt
    python setup.py test
    python setup.py checkdocs
else
    docker run -e PKG_NAME=${PKG_NAME} \
    -e PRJ_NAME="${PRJ_NAME}" -e BGEN="${BGEN}" -e LIKNORM="${LIKNORM}" \
    -e ZSTD="${ZSTD}" \
    --rm -v `pwd`:/io $DOCKER_IMAGE /io/travis/test-before-install-manylinux.sh
fi
