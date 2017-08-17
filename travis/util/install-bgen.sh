#!/bin/bash
set -e -x

pushd .
rm -rf bgen-build || true
git clone https://github.com/limix/bgen.git bgen-build
cd bgen-build
mkdir build
cd build
cmake ..
make
make test

set +e
sudo &> /dev/null
err="$?"
if [[ "$err" == "1" ]]; then
    SUDO="sudo"
else
    SUDO=""
fi
set -e

eval "$SUDO" make install
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    eval "$SUDO" ldconfig
fi
popd
rm -rf bgen-build || true
