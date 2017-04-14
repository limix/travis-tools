#!/bin/bash
set -e -x

PYBINFILE="$1"

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    brew install pandoc libffi
fi

pip install pypandoc -q
$PYBINFILE -c "from pypandoc import download_pandoc as dp; dp(targetfolder='~/bin/');"
