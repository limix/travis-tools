#!/bin/bash
set -e -x

pip install pypandoc -q

if [ ! -f "$HOME/bin/pandoc" ]; then
    python -c "from pypandoc import download_pandoc as dp; dp(targetfolder='~/bin/');"
fi
