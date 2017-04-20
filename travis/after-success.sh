#!/bin/bash
set -e -x

if ! [ -z ${DOCKER_IMAGE+x} ]; then
    docker run -e PYPI_PASSWORD=${PYPI_PASSWORD} -e PKG_NAME=${PKG_NAME} \
        -e PY_DEPS=${PY_DEPS} --rm -v `pwd`:/io $DOCKER_IMAGE /bin/bash
    pip install twine "${PY_DEPS[@]}" -q
    twine upload ${TRAVIS_BUILD_DIR}/wheelhouse/${PKG_NAME}*.whl \
          -u dhorta -p ${PYPI_PASSWORD} || true
else
    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        source ~/.venv/bin/activate
        pip install twine "${PY_DEPS[@]}" -q
        twine upload ${TRAVIS_BUILD_DIR}/dist/${PKG_NAME}*.whl \
              -u dhorta -p ${PYPI_PASSWORD} || true
    fi
fi
