#!/bin/bash
set -e -x

pushd .

rm -f v1.3.1.tar.gz || true
rm -rf zstd-1.3.1 || true
rm -rf zstd-build || true

wget https://github.com/facebook/zstd/archive/v1.3.1.tar.gz
tar xzf v1.3.1.tar.gz
mv zstd-1.3.1 zstd-build
cd zstd-build

make

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

rm -rf zstd-build || true
