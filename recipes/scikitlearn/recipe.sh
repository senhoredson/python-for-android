#!/bin/bash

VERSION_scikitlearn=${VERSION_scikitlearn:-0.15.2}
DEPS_scikitlearn=(numpy)
URL_scikitlearn=https://pypi.python.org/packages/source/s/scikit-learn/scikit-learn-$VERSION_scikitlearn.tar.gz
MD5_scikitlearn=d9822ad0238e17b382a3c756ea94fe0d
BUILD_scikitlearn=$BUILD_PATH/scikitlearn/$(get_directory $URL_scikitlearn)
RECIPE_scikitlearn=$RECIPES_PATH/scikitlearn

function prebuild_scikitlearn() {
	true
}

function shouldbuild_scikitlearn() {
	if [ -d "$SITEPACKAGES_PATH/scikitlearn" ]; then
		DO_BUILD=0
	fi
}

function build_scikitlearn() {

	cd $BUILD_scikitlearn

	push_arm
	$HOSTPYTHON setup.py build_ext	
	$HOSTPYTHON setup.py build_ext -v
	$HOSTPYTHON setup.py install
	find build/lib.* -name "*.o" -exec $STRIP {} \;
	pop_arm

}

function postbuild_scikitlearn() {
	true
}
