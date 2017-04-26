#!/bin/bash
set -e -x

mkdir -p $HOME/.download

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        source travis/prepare-for-osx.sh
    fi

    pip install wheel setuptools cython numpy --upgrade -q

    if ! [ -z ${PY_DEPS} ]; then
        eval pip install ${PY_DEPS} --upgrade -q
    fi

    source travis/install-pandoc.sh

    if [ "${LIKNORM}" == "true" ]; then
        travis/install-liknorm.sh
    fi
else
    docker pull $DOCKER_IMAGE
fi

travis/test-before-install.sh
