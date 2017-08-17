#!/bin/bash

yum install -y atlas-devel libffi libffi-devel ccache cmake zlib zlib-devel

if [ ! -f /root/bin/ccache ]; then
    mkdir /root/bin
    export PATH=/root/bin:$PATH

    cp /usr/bin/ccache /root/bin/

    ln -s ccache /root/bin/gcc
    ln -s ccache /root/bin/g++
    ln -s ccache /root/bin/cc
    ln -s ccache /root/bin/c++

    hash -r
fi
