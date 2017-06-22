#!/bin/bash
set -e

mkdir -p travis

URL_PREFIX=https://raw.githubusercontent.com/limix/travis-tools/master/travis/

pushd travis
curl -O ${URL_PREFIX}/after-success.sh
chmod +x after-success.sh
curl -O ${URL_PREFIX}/before-install.sh
chmod +x before-install.sh
curl -O ${URL_PREFIX}/build-wheels.sh
chmod +x build-wheels.sh
curl -O ${URL_PREFIX}/install-bgen.sh
chmod +x install-bgen.sh
curl -O ${URL_PREFIX}/install-clang38.sh
chmod +x install-clang38.sh
curl -O ${URL_PREFIX}/install-llvmlite.sh
chmod +x install-llvmlite.sh
curl -O ${URL_PREFIX}/install-liknorm.sh
chmod +x install-liknorm.sh
curl -O ${URL_PREFIX}/install-pandoc.sh
chmod +x install-pandoc.sh
curl -O ${URL_PREFIX}/prepare-for-osx.sh
chmod +x prepare-for-osx.sh
curl -O ${URL_PREFIX}/script.sh
chmod +x script.sh
curl -O ${URL_PREFIX}/pip-test.sh
chmod +x pip-test.sh
curl -O ${URL_PREFIX}/test-before-install.sh
chmod +x test-before-install.sh
curl -O ${URL_PREFIX}/test-before-install-manylinux.sh
chmod +x test-before-install-manylinux.sh
popd
