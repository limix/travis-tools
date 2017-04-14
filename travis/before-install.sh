#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        travis/prepare-for-osx.sh
    fi
    travis/install-pandoc.sh python
else
    docker pull $DOCKER_IMAGE
fi
