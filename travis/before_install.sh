#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        travis/prepare_for_osx.sh
    fi
    travis/install_pandoc.sh
else
    docker pull $DOCKER_IMAGE
fi
