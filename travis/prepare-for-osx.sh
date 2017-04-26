#!/bin/bash
set -e -x

brew update > /dev/null

brew install libffi > /dev/null

if [ "$HDF5" == "true" ]; then
    brew install homebrew/science/hdf5 > /dev/null
fi

rm -rf ~/.pyenv || true
git clone --depth 1 https://github.com/yyuu/pyenv.git ~/.pyenv

PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

case "${PYENV}" in
    py27)
        getbin="$HOME/.download/get-pip.py"
        if [ ! -f "$getbin" ]; then
            curl -o "$getbin" https://bootstrap.pypa.io/get-pip.py
            python "$getbin" --user
        fi
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

# matplotlib does not like travis osx
mkdir -p ~/.matplotlib
echo "backend: TkAgg" > ~/.matplotlib/matplotlibrc
