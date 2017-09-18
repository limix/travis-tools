#!/bin/bash
set -e -x

pushd .
rm -rf hcephes-build || true
wget https://github.com/limix/hcephes/archive/0.1.3.tar.gz
tar xzf 0.1.3.tar.gz
mv hcephes-0.1.3 hcephes-build
cd hcephes-build
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
rm -rf hcephes-build || true
