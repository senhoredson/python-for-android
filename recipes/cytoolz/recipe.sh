#!/bin/bash

VERSION_cytoolz=${VERSION_cytoolz:-0.7.3}
DEPS_cytoolz=(setuptools)
URL_cytoolz=https://pypi.python.org/packages/source/c/cytoolz/cytoolz-$VERSION_cytoolz.tar.gz
MD5_cytoolz=e9f0441d9f340a23c60357f68f25d163
BUILD_cytoolz=$BUILD_PATH/cytoolz/$(get_directory $URL_cytoolz)
RECIPE_cytoolz=$RECIPES_PATH/cytoolz

function prebuild_cytoolz() {
	true
}

function shouldbuild_cytoolz() {
	if [ -d "$SITEPACKAGES_PATH/cytoolz" ]; then
		DO_BUILD=0
	fi
}

function build_cytoolz() {

	cd $BUILD_cytoolz

	push_arm

	$HOSTPYTHON setup.py build_ext
	try find . -iname '*.pyx' -exec cython {} \;
	try $HOSTPYTHON setup.py build_ext -v
	try find build/lib.* -name "*.o" -exec $STRIP {} \;
	try $HOSTPYTHON setup.py install -O2

	pop_arm
}

function postbuild_cytoolz() {
	true
}
