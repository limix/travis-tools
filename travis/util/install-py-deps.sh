#!/bin/bash

$1/pip install wheel setuptools rstcheck --upgrade -q
$1/pip install cython --upgrade -q
$1/pip install pyarrow --upgrade -q
