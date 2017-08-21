#!/bin/bash
set -e

source /io/travis/util/install-manylinux-deps.sh
source /io/travis/util/install-deps.sh

FOLDERS="$(echo /opt/python/*p27*/bin) $(echo /opt/python/*p36*/bin)"

for F in $FOLDERS; do
    $F/pip install setuptools --upgrade -q
    $F/pip install -U -r /io/requirements.txt -r /io/test-requirements.txt
    $F/pip wheel /io/ -w wheelhouse/
done

ls wheelhouse/ || true

(shopt -s nullglob; rm -f wheelhouse/${PKG_NAME}-*-any.whl)

shopt -s nullglob
files=(wheelhouse/${PKG_NAME}-*.whl)
shopt -u nullglob

if [ ${#files[@]} -gt 0 ]; then

    # Bundle external shared libraries into the wheels
    for whl in wheelhouse/${PKG_NAME}-*.whl; do
        auditwheel repair "$whl" -w /io/wheelhouse/
    done

    # Install and test packages
    for F in $FOLDERS; do
        $F/pip install ${PKG_NAME} -f /io/wheelhouse  -q
        cd "$HOME"
        /io/travis/util/pip-test.sh $F
    done

fi
