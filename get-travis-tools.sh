#!/bin/bash
set -e -x

mkdir -p travis

$URL_PREFIX=https://raw.githubusercontent.com/limix/travis-tools/master/travis/

pushd travis
curl -O ${URL_PREFIX}/after-success.sh
curl -O ${URL_PREFIX}/before-install.sh
curl -O ${URL_PREFIX}/build-wheels.sh
curl -O ${URL_PREFIX}/deploy-wheels.sh
curl -O ${URL_PREFIX}/install-pandoc.sh
curl -O ${URL_PREFIX}/prepare-for-osx.sh
curl -O ${URL_PREFIX}/script.sh
curl -O ${URL_PREFIX}/test.sh
popd
