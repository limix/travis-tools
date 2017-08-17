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
ls /io/wheelhouse/ || true

(shopt -s nullglob; rm -f wheelhouse/${PRJ_NAME}-*-any.whl)
(shopt -s nullglob; rm -f /io/wheelhouse/${PRJ_NAME}-*-any.whl)

shopt -s nullglob
files=(wheelhouse/${PRJ_NAME}-*.whl)
shopt -u nullglob

if [ ${#files[@]} -gt 0 ]; then

    # Bundle external shared libraries into the wheels
    for whl in wheelhouse/${PRJ_NAME}-*.whl; do
        auditwheel repair "$whl" -w /io/wheelhouse/
    done

    # Install and test packages
    for F in $FOLDERS; do
        $F/pip install ${PRJ_NAME} -f /io/wheelhouse  -q
        cd "$HOME"
        /io/travis/util/pip-test.sh $F
    done

fi