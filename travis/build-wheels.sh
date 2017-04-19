#!/bin/bash
set -e -x

yum install -y atlas-devel libffi libffi-devel

/io/travis/install-hdf5.sh
export HDF5_DIR=/hdf5

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN == *"p26"* ]] || [[ $PYBIN == *"p33"* ]] || \
       [[ $PYBIN == *"p34"* ]]; then
        continue
    fi
    "${PYBIN}/pip" install numpy cython -q
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
