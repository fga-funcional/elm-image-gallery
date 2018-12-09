#!/bin/bash

set -o pipefail

JS_FILE=elm.js
JS_MINIFIED_FILE=elm.min.js

STATIC_FOLDER=static
SOURCE_FOLDER=src
SASS_FOLDER=scss

TMP_FOLDER=/tmp/.elm_compiler

aux_compile_elm() {
	echo "Compiling Elm..." &&
	elm make $SOURCE_FOLDER/Main.elm --optimize --output=$STATIC_FOLDER/$JS_FILE
}

minifying_js() {
	echo "Minifying JS..." &&
	(uglifyjs $STATIC_FOLDER/$JS_FILE --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$STATIC_FOLDER/$JS_MINIFIED_FILE)
}

copy_files() {
	rm -rf $TMP_FOLDER && mkdir -p $TMP_FOLDER
	find $PWD/$SOURCE_FOLDER -name *.elm > $TMP_FOLDER/.files_list
	cat $TMP_FOLDER/.files_list | xargs -I file cp file $TMP_FOLDER/
}

compile_and_minify() {
	aux_compile_elm && echo "" && minifying_js && echo "OK!"
}

compile_elm() {
	compile_and_minify
	copy_files

	if [ "$1" == "watch" ]; then
		echo -e "\n\n\nEntered Watch mode"
		echo -e "Waiting for changes..."
		while true
		do
			for file in $(cat $TMP_FOLDER/.files_list); do
				cmp --silent $file $TMP_FOLDER/$(basename $file)
				if [ $? -eq 1 ]; then
					compile_and_minify
					copy_files
					echo -e "\n\n\nWaiting for changes..."
				fi
			done
			sleep 2
		done
	fi
}

compile_sass() {
	if [ "$1" == "watch" ]; then
		echo "Compiling sass and entering watch mode..."
		sass $SASS_FOLDER/main.scss $STATIC_FOLDER/main.css --watch
	else
		echo "Compiling sass..."
		sass $SASS_FOLDER/main.scss $STATIC_FOLDER/main.css
	fi
}

if [ "$1" == "--help" ]; then
	echo "Usage: ./compile.sh [OPTION]"
	echo "where OPTION := { elm | css | both }"
	echo ""
	echo "elm			compile elm code, minify javascript and starts watching elm code for changes"
	echo "sass			compile sass code and enter and starts watching sass modifications for changes"
	echo "both			compile elm, minify js and compile sass"
	echo ""
	echo "If no option is passed, 'both' will be assumed."
	exit 0
fi

mkdir -p $STATIC_FOLDER

[ $1 ] && option=$1 || option="both"

if [ "$option" == "elm" ]; then
	compile_elm watch
elif [ "$option" == "sass" ]; then
	compile_sass watch
elif [ "$option" == "both" ]; then
	echo -e "Compiling Elm and CSS\n"
	compile_elm && echo "" && compile_sass
else
	echo "Invalid Option!"
	exit -1
fi

echo "OK!" || echo "Failed!"
