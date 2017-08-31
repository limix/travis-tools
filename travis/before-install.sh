#!/bin/bash
set -e

echo "
##############################################################################
############################ BEFORE INSTALL BEGIN ############################
##############################################################################
"

mkdir -p $HOME/.download

set -x
source travis/util/define-names.sh

DOCK=true && [[ -z "${DOCKER_IMAGE+x}" ]] && DOCK=false || true

if [ "$DOCK" = true ]; then

    docker pull $DOCKER_IMAGE
    CMD=/io/travis/before-install-manylinux.sh
    docker run --env-file ~/env.list --rm -v `pwd`:/io $DOCKER_IMAGE $CMD

else

    if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
        source travis/util/prepare-for-osx.sh
    fi

    source travis/util/install-py-deps.sh $(dirname $(which python))
    source travis/util/install-deps.sh
    pip install -U -r requirements.txt -r test-requirements.txt
    python setup.py test
    rstcheck README.rst

fi

set +x

echo "
##############################################################################
############################# BEFORE INSTALL END #############################
##############################################################################
"
