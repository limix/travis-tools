#!/bin/bash

$1/pip install wheel setuptools rstcheck pyarrow --upgrade -q
$1/pip install pyarrow -v
