#!/bin/bash
set -e -x

yum install -y atlas-devel libffi libffi-devel

for PYBIN in /opt/python/*/bin; do
    if [[ $PYBIN == *"p26"* ]] || [[ $PYBIN == *"p33"* ]] || \
       [[ $PYBIN == *"p34"* ]]; then
        continue
    fi
    pip install setuptools --upgrade -q
    pip install cython --upgrade -q
    eval "${PYBIN}/pip" install "${PY_DEPS}" -q
    "${PYBIN}/python" setup.py test
done
