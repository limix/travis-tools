#!/bin/bash
set -e -x

brew update || brew update
brew install pandoc libffi
brew install homebrew/science/hdf5

git clone --depth 1 https://github.com/yyuu/pyenv.git ~/.pyenv

PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

case "${PYENV}" in
    py27)
        curl -O https://bootstrap.pypa.io/get-pip.py
        python get-pip.py --user
        ;;
    py35)
        pyenv install 3.5.2
        pyenv global 3.5.2
        ;;
    py36)
        pyenv install 3.6.0
        pyenv global 3.6.0
        ;;
esac
pyenv rehash
python -m pip install --user virtualenv

python -m virtualenv ~/.venv
source ~/.venv/bin/activate
pip install wheel setuptools pytest "${PY_DEPS[@]}" -q
