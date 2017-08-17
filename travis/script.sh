#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then

    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        source ~/.venv/bin/activate
    fi

    travis/pip-test.sh ""
else
    exit 0
fi
