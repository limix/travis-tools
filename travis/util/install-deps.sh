#!/bin/bash

if [ "$ZSTD" = true ]; then
    source travis/util/install-zstd.sh
fi

if [ "$BGEN" = true ]; then
    source travis/util/install-bgen.sh
fi

if [ "$LIKNORM" = true ]; then
    source travis/util/install-liknorm.sh
fi
