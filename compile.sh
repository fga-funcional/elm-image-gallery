#!/bin/bash

set -o pipefail

JS_FILE=elm.js
JS_MINIFIED_FILE=elm.min.js

STATIC_FOLDER=static
SOURCE_FOLDER=src

mkdir -p $STATIC_FOLDER

echo "Compiling..." &&
elm make $SOURCE_FOLDER/*.elm --optimize --output=$STATIC_FOLDER/$JS_FILE &&

echo "" &&

echo "Minifying..." &&
(uglifyjs $STATIC_FOLDER/$JS_FILE --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$STATIC_FOLDER/$JS_MINIFIED_FILE) &&

echo "OK!" || echo "Failed!"
