#!/bin/bash
set -e

mkdir -p travis/util

URL_PREFIX=https://raw.githubusercontent.com/limix/travis-tools/master/travis/

pushd travis

function get_script
{
        urlpath="$1"
        curl "$URL_PREFIX/$urlpath > $urlpath"
        chmod +x "$urlpath"
}

files="
after-success.sh
before-install.sh
install.sh
script.sh
util/build-wheels.sh
util/install-bgen.sh
util/install-liknorm.sh
util/install-zstd.sh
util/prepare-for-osx.sh
util/pip-test.sh
util/test-before-install.sh
util/test-before-install-manylinux.sh
"

for f in $files
do
    get_script $f &
done
