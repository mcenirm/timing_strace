#!/bin/sh

set -e

cd build
make -j8 prefix="$OLDPWD/prefix" all
