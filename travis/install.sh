#!/bin/bash
set -e

echo "
111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111 INSTALL BEGIN 1111111111111111111111111111111
111111111111111111111111111111111111111111111111111111111111111111111111111111
"

DOCK=true && [[ -z "${DOCKER_IMAGE+x}" ]] && DOCK=false || true

set -x
source travis/util/define-names.sh

if [ "$DOCK" = true ]; then

    CMD=/io/travis/util/build-wheels.sh
    docker run --env-file ~/env.list --rm -v `pwd`:/io $DOCKER_IMAGE $CMD
else
    if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
        pip install -U -r requirements.txt -r test-requirements.txt
        python setup.py sdist
        filename="$(ls dist | grep -i -E '\.(gz)$' | head -1)"
        tar -ztvf dist/$filename | grep LICENSE
        pip install dist/$filename
    else
        source ~/.venv/bin/activate
        pip install -U -r requirements.txt -r test-requirements.txt
        python setup.py bdist_wheel
        filename="$(ls dist | grep -i -E '\.(whl)$' | head -1)"
        pip install dist/$filename
    fi

fi

set +x

echo "
111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111111111111111 INSTALL END 11111111111111111111111111111111
111111111111111111111111111111111111111111111111111111111111111111111111111111
"
