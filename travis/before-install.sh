#!/bin/bash
set -e -x

mkdir -p $HOME/.download

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        source travis/prepare-for-osx.sh
    fi

    pip install wheel setuptools --upgrade -q

    if [[ "${ZSTD}" == "true" ]]; then
        source travis/install-zstd.sh
    fi

    if [[ "${BGEN}" == "true" ]]; then
        source travis/install-bgen.sh
    fi

    if [[ "${LIKNORM}" == "true" ]]; then
        source travis/install-liknorm.sh
    fi
else
    docker pull $DOCKER_IMAGE
fi

travis/test-before-install.sh
