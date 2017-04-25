#!/bin/bash
set -e -x

if [ -z ${DOCKER_IMAGE+x} ]; then

    if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
        python setup.py sdist
        pip install dist/`ls dist | grep -i -E '\.(gz)$' | head -1`;
    else
        source ~/.venv/bin/activate
        python setup.py bdist_wheel
        pip install dist/`ls dist | grep -i -E '\.(whl)$' | head -1`;
    fi
    travis/pip-test.sh ""
else
    if [ "${NUMBA}" == "true" ]; then
        echo "We don't support numba and manylinux together."
        echo "Please, set \$NUMBA to false or remove it."
        exit 1
    fi
    
    docker run -e PKG_NAME=${PKG_NAME} -e PY_DEPS="${PY_DEPS}" \
        -e LIKNORM="${LIKNORM}" \
        --rm -v `pwd`:/io $DOCKER_IMAGE /io/travis/build-wheels.sh
fi
