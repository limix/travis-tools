#!/bin/bash
set -e

pushd /io
source travis/util/install-manylinux-deps.sh
source travis/util/install-deps.sh
popd

FOLDERS="$(echo /opt/python/*p27*/bin) $(echo /opt/python/*p36*/bin)"

for F in $FOLDERS; do
    source /io/travis/util/install-py-deps.sh $F
    $F/pip install -U -r /io/requirements.txt -r /io/test-requirements.txt
    $F/python /io/setup.py test
done
