#!/bin/bash
set -e -x

PYBIN="$1"

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    brew install pandoc libffi
fi

pip install pypandoc
$PYBIN -c "from pypandoc import download_pandoc as dp; dp(targetfolder='~/bin/');"
