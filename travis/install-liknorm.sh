#!/bin/bash
set -e -x

pushd .
git clone https://github.com/limix/liknorm.git liknorm-build
cd liknorm-build
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
