#!/bin/bash
set -e -x

yum install -y atlas-devel libffi libffi-devel ccache cmake

if [ ! -f /root/bin/ccache ]; then
    mkdir /root/bin
    export PATH=/root/bin:$PATH

    cp /usr/bin/ccache /root/bin/

    ln -s ccache /root/bin/gcc
    ln -s ccache /root/bin/g++
    ln -s ccache /root/bin/cc
    ln -s ccache /root/bin/c++

    hash -r
fi

if [ "${BGEN}" == "true" ]; then
    source /io/travis/install-bgen.sh
fi

if [ "${LIKNORM}" == "true" ]; then
    source /io/travis/install-liknorm.sh
fi

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN == *"p26"* ]] || [[ $PYBIN == *"p33"* ]] || \
    [[ $PYBIN == *"p34"* ]]; then
        continue
    fi
    "${PYBIN}/pip" install setuptools cython numpy --upgrade -q
    "${PYBIN}/pip" wheel /io/ -w wheelhouse/
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
    for PYBIN in /opt/python/*/bin/; do
        if [[ $PYBIN == *"p26"* ]] || [[ $PYBIN == *"p33"* ]] \
        || [[ $PYBIN == *"p34"* ]]; then
            continue
        fi

        eval "${PYBIN}/pip" install "${PRJ_NAME}" -f /io/wheelhouse  -q
        cd "$HOME"
        /io/travis/pip-test.sh "${PYBIN}"
    done

fi
