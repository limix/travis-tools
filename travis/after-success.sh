#!/bin/bash
set -e -x

if [ -z "${PRJ_NAME}" ]; then
    export PRJ_NAME="${PKG_NAME}"
fi

if ! [ -z ${TRAVIS_TAG} ]; then

    if ! [ -z ${DOCKER_IMAGE+x} ]; then
        docker run -e PYPI_PASSWORD=${PYPI_PASSWORD} -e PKG_NAME=${PKG_NAME} \
            -e LIKNORM="${LIKNORM}" -e PY_DEPS="${PY_DEPS}" \
            -e PRJ_NAME="${PRJ_NAME}" --rm -v \
            `pwd`:/io $DOCKER_IMAGE /bin/bash

        pip install setuptools twine numpy cython --upgrade -q

        twine upload ${TRAVIS_BUILD_DIR}/wheelhouse/${PRJ_NAME}*.whl \
              -u dhorta -p ${PYPI_PASSWORD} || true
    else
        if [[ $TRAVIS_OS_NAME == 'osx' ]]; then

            source ~/.venv/bin/activate
            pip install setuptools twine numpy cython --upgrade -q

            twine upload ${TRAVIS_BUILD_DIR}/dist/${PRJ_NAME}*.whl \
                  -u dhorta -p ${PYPI_PASSWORD} || true
        fi
    fi

fi
