#!/bin/bash
set -e -x

export LLVM_VERSION="3.8"
export CXX="clang++-3.8"
export LLVM_CONFIG="llvm-config-3.8"
export PATH=~/bin:$PATH

if [ "${TRAVIS_PYTHON_VERSION}" == "2.7" ];
then
  pip install enum34 -q
fi

wget https://github.com/numba/llvmlite/archive/v0.15.0.tar.gz
tar xzf v0.15.0.tar.gz

pushd llvmlite-0.15.0
CXX_FLTO_FLAGS= LD_FLTO_FLAGS= python setup.py install
popd
