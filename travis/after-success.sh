#!/bin/bash
set -e

echo "
333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333333333333333 AFTER SUCCESS BEGIN 333333333333333333333333333
333333333333333333333333333333333333333333333333333333333333333333333333333333
"

set -x

if ! [ -z "${DONT_RELEASE_WHEEL+x}" ]; then
    if [ "${DONT_RELEASE_WHEEL}" == "true" ]; then
        exit 0
    fi
fi

if [ -z "${PRJ_NAME}" ]; then
    export PRJ_NAME="${PKG_NAME}"
fi

if ! [ -z ${TRAVIS_TAG} ]; then

    if ! [ -z ${DOCKER_IMAGE+x} ]; then
        docker run -e PYPI_PASSWORD=${PYPI_PASSWORD} -e PKG_NAME=${PKG_NAME} \
        -e LIKNORM="${LIKNORM}" -e ZSTD="${ZSTD}" \
        -e BGEN="${BGEN}" -e PRJ_NAME="${PRJ_NAME}" --rm -v \
        `pwd`:/io $DOCKER_IMAGE /bin/bash

        pip install twine --upgrade -q

        twine upload ${TRAVIS_BUILD_DIR}/wheelhouse/${PRJ_NAME}*.whl \
        -u dhorta -p ${PYPI_PASSWORD} || true
    else
        if [[ $TRAVIS_OS_NAME == 'osx' ]]; then

            source ~/.venv/bin/activate
            pip install twine --upgrade -q

            twine upload ${TRAVIS_BUILD_DIR}/dist/${PRJ_NAME}*.whl \
            -u dhorta -p ${PYPI_PASSWORD} || true
        fi
    fi
fi

set +x

echo "
333333333333333333333333333333333333333333333333333333333333333333333333333333
3333333333333333333333333333333 AFTER SUCCESS END 3333333333333333333333333333
333333333333333333333333333333333333333333333333333333333333333333333333333333
"
