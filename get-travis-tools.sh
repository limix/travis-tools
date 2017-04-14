#!/bin/bash
set -e -x

mkdir -p travis

URL_PREFIX=https://raw.githubusercontent.com/limix/travis-tools/master/travis/

pushd travis
curl -O ${URL_PREFIX}/after-success.sh
chmod +x after-success.sh
curl -O ${URL_PREFIX}/before-install.sh
chmod +x before-install.sh
curl -O ${URL_PREFIX}/build-wheels.sh
chmod +x build-wheels.sh
curl -O ${URL_PREFIX}/deploy-wheels.sh
chmod +x deploy-wheels.sh
curl -O ${URL_PREFIX}/install-pandoc.sh
chmod +x install-pandoc.sh
curl -O ${URL_PREFIX}/prepare-for-osx.sh
chmod +x prepare-for-osx.sh
curl -O ${URL_PREFIX}/script.sh
chmod +x script.sh
curl -O ${URL_PREFIX}/test.sh
chmod +x test.sh
popd
