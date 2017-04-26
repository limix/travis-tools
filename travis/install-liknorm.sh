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
sudo make install
if [[ $TRAVIS_OS_NAME == 'linux' ]]; then
    sudo ldconfig
fi
popd
