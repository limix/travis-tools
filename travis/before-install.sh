#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        travis/prepare-for-osx.sh
    fi

    pip install wheel setuptools cython numpy --upgrade -q

    travis/install-pandoc.sh python

    if [ "${LIKNORM}" == "true" ]; then
        travis/install-liknorm.sh
    fi
else
    docker pull $DOCKER_IMAGE
fi

travis/test-before-install.sh
