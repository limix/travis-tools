#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME != 'linux' ]]; then
        source ~/.venv/bin/activate
    fi
    pip install h5py -q
    python setup.py test
else
    docker run -e PKG_NAME=${PKG_NAME} \
        --rm -v `pwd`:/io $DOCKER_IMAGE /io/travis/test-before-install-manylinux.sh
fi
