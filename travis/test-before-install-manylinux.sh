#!/bin/bash
set -e -x

yum install -y atlas-devel libffi libffi-devel ccache cmake zlib zlib-devel

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

if [ "${ZSTD}" == "true" ]; then
    source /io/travis/install-zstd.sh
fi

if [ "${BGEN}" == "true" ]; then
    source /io/travis/install-bgen.sh
fi

if [ "${LIKNORM}" == "true" ]; then
    source /io/travis/install-liknorm.sh
fi

for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN == *"p36"* ]]; then
        "${PYBIN}/pip" install cython setuptools numpy pytest pytest-pep8 --upgrade -q
        eval "${PYBIN}/pip" install "${PY_DEPS}" --upgrade -q
        pushd /io
        "${PYBIN}/python" setup.py test
        popd
    fi
done
