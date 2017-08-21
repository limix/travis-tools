#!/bin/bash
set -e

echo "
##############################################################################
############################## AFTER SUCCESS BEGIN ###########################
##############################################################################
"

DOCK=true && [[ -z "${DOCKER_IMAGE+x}" ]] && DOCK=false || true

set -x

echo "(AFTER_SUCCESS) Defining names."
source travis/util/define-names.sh

echo "(AFTER_SUCCESS) Shall we deploy WHEEL?"
if ! [ -z "${DONT_RELEASE_WHEEL+x}" ]; then
    if [ "${DONT_RELEASE_WHEEL}" == "true" ]; then
        exit 0
    fi
fi

if ! [ -z ${TRAVIS_TAG} ]; then
    echo "(AFTER_SUCCESS) Tagged commit. Deploying stage."

    if [ "$DOCK" = true ]; then

        echo "(AFTER_SUCCESS) Run docker image and upload ${PKG_NAME} wheels."
        CMD=/bin/bash
        docker run --env-file ~/env.list -e PYPI_PASSWORD=${PYPI_PASSWORD}  \
            --rm -v `pwd`:/io $DOCKER_IMAGE $CMD

        pip install twine --upgrade -q

        twine upload ${TRAVIS_BUILD_DIR}/wheelhouse/${PKG_NAME}*.whl \
            -u dhorta -p ${PYPI_PASSWORD} || true
    else
        if [[ $TRAVIS_OS_NAME == 'osx' ]]; then

            
            echo "(AFTER_SUCCESS) Activate Python environment and upload ${PKG_NAME} wheels."
            source ~/.venv/bin/activate
            pip install twine --upgrade -q

            twine upload ${TRAVIS_BUILD_DIR}/dist/${PKG_NAME}*.whl \
                -u dhorta -p ${PYPI_PASSWORD} || true
        fi
    fi
fi

set +x

echo "
##############################################################################
############################### AFTER SUCCESS END ############################
##############################################################################
"
