#!/bin/bash
set -e

echo "
111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111 INSTALL BEGIN 1111111111111111111111111111111
111111111111111111111111111111111111111111111111111111111111111111111111111111
"

set -x

if [ -z "${PRJ_NAME}" ]; then
    export PRJ_NAME="${PKG_NAME}"
fi

if [ -z ${DOCKER_IMAGE+x} ]; then

    if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
        pip install -U -r requirements.txt -r test-requirements.txt
        python setup.py sdist
        pip install dist/`ls dist | grep -i -E '\.(gz)$' | head -1`;
    else
        source ~/.venv/bin/activate
        pip install -U -r requirements.txt -r test-requirements.txt
        python setup.py bdist_wheel
        pip install dist/`ls dist | grep -i -E '\.(whl)$' | head -1`;
    fi
else
    docker run -e PKG_NAME=${PKG_NAME} \
        -e LIKNORM="${LIKNORM}" -e PRJ_NAME="${PRJ_NAME}" \
        -e BGEN="${BGEN}" -e ZSTD="${ZSTD}" \
        --rm -v `pwd`:/io $DOCKER_IMAGE /io/travis/util/build-wheels.sh
fi

set +x

echo "
111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111111111111111 INSTALL END 11111111111111111111111111111111
111111111111111111111111111111111111111111111111111111111111111111111111111111
"
