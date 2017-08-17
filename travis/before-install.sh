#!/bin/bash
set -e

echo "
000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000 BEFORE INSTALL BEGIN 0000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000
"

mkdir -p $HOME/.download

if [ -z "${PRJ_NAME}" ]; then
    export PRJ_NAME="${PKG_NAME}"
fi

set -x

echo "
PKG_NAME=${PKG_NAME}
PRJ_NAME=${PRJ_NAME}
BGEN=${BGEN}
LIKNORM=${LIKNORM}
ZSTD=${ZSTD}
" > ~/env.list

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
000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000 BEFORE INSTALL END 00000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000
"
