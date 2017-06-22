#!/bin/bash
set -e -x

mkdir -p $HOME/.download

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        source travis/prepare-for-osx.sh
    fi

    pip install wheel setuptools cython numpy --upgrade -q

    if [[ "${ZSTD}" == "true" ]]; then
        source travis/install-zstd.sh
    fi

    if [[ "${BGEN}" == "true" ]]; then
        source travis/install-bgen.sh
    fi

    if [[ "${LIKNORM}" == "true" ]]; then
        source travis/install-liknorm.sh
    fi

    if ! [ -z "${PY_DEPS}" ]; then
        eval pip install "${PY_DEPS}" --upgrade -q
    fi

    source travis/install-pandoc.sh
else
    docker pull $DOCKER_IMAGE
fi

travis/test-before-install.sh
