#!/bin/bash
set -e -x

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
    travis/pip-test.sh ""
else
    docker run -e PKG_NAME=${PKG_NAME} \
        -e LIKNORM="${LIKNORM}" -e PRJ_NAME="${PRJ_NAME}" \
        -e BGEN="${BGEN}" -e ZSTD="${ZSTD}" \
        --rm -v `pwd`:/io $DOCKER_IMAGE /io/travis/build-wheels.sh
fi
