#!/bin/bash
set -e -x

mkdir -p travis

pushd travis
curl -O https://github.com/limix/travis-tools/blob/master/travis/after-success.sh
curl -O https://github.com/limix/travis-tools/blob/master/travis/before-install.sh
curl -O https://github.com/limix/travis-tools/blob/master/travis/build-wheels.sh
curl -O https://github.com/limix/travis-tools/blob/master/travis/deploy-wheels.sh
curl -O https://github.com/limix/travis-tools/blob/master/travis/install-pandoc.sh
curl -O https://github.com/limix/travis-tools/blob/master/travis/prepare-for-osx.sh
curl -O https://github.com/limix/travis-tools/blob/master/travis/script.sh
curl -O https://github.com/limix/travis-tools/blob/master/travis/test.sh
popd
