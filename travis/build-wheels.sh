#!/bin/bash
set -e -x

yum install -y atlas-devel libffi libffi-devel ccache

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

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN == *"p26"* ]] || [[ $PYBIN == *"p33"* ]] || \
       [[ $PYBIN == *"p34"* ]]; then
        continue
    fi
    "${PYBIN}/pip" install setuptools --upgrade -q
    "${PYBIN}/pip" install cython --upgrade -q
    eval "${PYBIN}/pip" install "${PY_DEPS}" -q
    "${PYBIN}/pip" wheel /io/ -w wheelhouse/  -q
done

# Bundle external shared libraries into the wheels
for whl in wheelhouse/${PKG_NAME}*.whl; do
    auditwheel repair "$whl" -w /io/wheelhouse/
done

# Install packages and test
for PYBIN in /opt/python/*/bin/; do
    if [[ $PYBIN == *"p26"* ]] || [[ $PYBIN == *"p33"* ]] \
        || [[ $PYBIN == *"p34"* ]]; then
        continue
    fi
    "${PYBIN}/pip" install $PKG_NAME -f /io/wheelhouse  -q
    "${PYBIN}/pip" install pytest -q
    cd "$HOME"
    /io/travis/test.sh "${PYBIN}/python"
done
