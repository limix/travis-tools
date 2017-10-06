#!/bin/bash

$1/pip install setuptools --upgrade -q
$1/pip install wheel rstcheck cython --upgrade -q
$1/pip install codecov pytest-cov --upgrade -q
