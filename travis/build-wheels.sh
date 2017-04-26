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
    "${PYBIN}/pip" install setuptools cython numpy --upgrade -q
    "${PYBIN}/pip" wheel /io/ -w wheelhouse/
done

ls wheelhouse/ || true
ls /io/wheelhouse/ || true

(shopt -s nullglob; rm -f wheelhouse/${PKG_NAME}*-any.whl)
(shopt -s nullglob; rm -f /io/wheelhouse/${PKG_NAME}*-any.whl)

files1=(/io/wheelhouse/${PKG_NAME}*.whl)
files2=(wheelhouse/${PKG_NAME}*.whl)
if [ ${#files1[@]} -gt 0 ] && [ ${#files2[@]} -gt 0 ]; then

    # Bundle external shared libraries into the wheels
    for whl in wheelhouse/${PKG_NAME}*.whl; do
        auditwheel repair "$whl" -w /io/wheelhouse/
    done

    # Install and test packages
    for PYBIN in /opt/python/*/bin/; do
        if [[ $PYBIN == *"p26"* ]] || [[ $PYBIN == *"p33"* ]] \
            || [[ $PYBIN == *"p34"* ]]; then
            continue
        fi

        "${PYBIN}/pip" install $PKG_NAME -f /io/wheelhouse  -q
        cd "$HOME"
        /io/travis/pip-test.sh "${PYBIN}"
    done

fi
