#!/bin/bash
set -e -x

yum install -y atlas-devel libffi libffi-devel

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN == *"p26"* ]] || [[ $PYBIN == *"p33"* ]] || \
       [[ $PYBIN == *"p34"* ]]; then
        continue
    fi
    "${PYBIN}/pip" wheel /io/ -w wheelhouse/
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
    "${PYBIN}/pip" install $PKG_NAME -f /io/wheelhouse
    "${PYBIN}/pip" install pytest
    cd "$HOME"
    travis/test.sh "${PYBIN}/python"
done
