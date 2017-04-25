#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        source travis/prepare-for-osx.sh
    fi

    which python
    which pip
    pip install wheel setuptools cython numpy --upgrade

    travis/install-pandoc.sh python

    if [ "${LIKNORM}" == "true" ]; then
        travis/install-liknorm.sh
    fi
else
    docker pull $DOCKER_IMAGE
fi

travis/test-before-install.sh
