#!/bin/bash
set -e

echo "
333333333333333333333333333333333333333333333333333333333333333333333333333333
333333333333333333333333333333 AFTER SUCCESS BEGIN 333333333333333333333333333
333333333333333333333333333333333333333333333333333333333333333333333333333333
"

DOCK=true && [[ -z "${DOCKER_IMAGE+x}" ]] && DOCK=false || true

set -x
source travis/util/define-names.sh

if ! [ -z "${DONT_RELEASE_WHEEL+x}" ]; then
    if [ "${DONT_RELEASE_WHEEL}" == "true" ]; then
        exit 0
    fi
fi

if ! [ -z ${TRAVIS_TAG} ]; then

    if [ "$DOCK" = true ]; then

        CMD=/bin/bash
        docker run --env-file ~/env.list -e PYPI_PASSWORD=${PYPI_PASSWORD}  \
            --rm -v `pwd`:/io $DOCKER_IMAGE $CMD

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
