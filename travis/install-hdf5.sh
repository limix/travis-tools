#!/bin/bash
set -e -x

pushd /
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.0-patch1/src/hdf5-1.10.0-patch1.tar.gz
tar xzf hdf5-1.10.0-patch1.tar.gz
cd hdf5-1.10.0-patch1
mkdir build
cd build
../configure --prefix=/hdf5
make
make install
popd
