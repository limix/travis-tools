#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        travis/prepare-for-osx.sh
    else
        if [ "${NUMBA}" == "true" ]; then
            travis/install-clang38.sh;
            travis/install-llvmlite.sh;
        fi
    fi
    pip install setuptools --upgrade -q
    pip install cython --upgrade -q
    eval pip install "${PY_DEPS}" -q
    travis/install-pandoc.sh python
    travis/install-liknorm.sh
else
    docker pull $DOCKER_IMAGE
fi
