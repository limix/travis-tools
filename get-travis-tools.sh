#!/bin/bash
set -e

mkdir -p travis/util

URL_PREFIX=https://raw.githubusercontent.com/limix/travis-tools/master/travis/

pushd travis

function get_script
{
        urlpath="$1"
        curl -s "$URL_PREFIX/$urlpath" > "$urlpath"
        chmod +x "$urlpath"
}

files="
after-success.sh
before-install-manylinux.sh
before-install.sh
install.sh
script.sh
util/build-wheels.sh
util/install-bgen.sh
util/install-deps.sh
util/install-liknorm.sh
util/install-manylinux-deps.sh
util/install-py-deps.sh
util/install-zstd.sh
util/pip-test.sh
util/prepare-for-osx.sh
"

for f in $files
do
    get_script $f &
done
wait

popd
