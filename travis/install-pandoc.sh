#!/bin/bash
set -e -x

if [[ $TRAVIS_OS_NAME == 'osx' ]]; then
    brew install pandoc libffi
fi

pip install pypandoc -q
python -c "from pypandoc import download_pandoc as dp; dp(targetfolder='~/bin/');"
