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
sudo ldconfig
popd
