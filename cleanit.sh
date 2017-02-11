#!/bin/sh

set -e

rm -rf prefix
rm -rf build
git clone -b maint git build
