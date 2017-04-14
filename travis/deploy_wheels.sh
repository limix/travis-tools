#!/bin/bash
set -e -x

if ! [ -z ${DOCKER_IMAGE+x} ]; then
    docker run -e PYPI_PASSWORD=${PYPI_PASSWORD} \
        PKG_NAME=${PKG_NAME} --rm -v `pwd`:/io $DOCKER_IMAGE /bin/bash
    pip install twine
    twine upload ${TRAVIS_BUILD_DIR}/wheelhouse/${PKG_NAME}*.whl \
        -u dhorta -p ${PYPI_PASSWORD}
else
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        source ~/.venv/bin/activate
        pip install twine
        twine upload ${TRAVIS_BUILD_DIR}/dist/${PKG_NAME}*.whl \
            -u dhorta -p ${PYPI_PASSWORD}
    fi
fi
