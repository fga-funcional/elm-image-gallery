#!/bin/bash

set -o pipefail

JS_FILE=elm.js
JS_MINIFIED_FILE=elm.min.js

STATIC_FOLDER=static
SOURCE_FOLDER=src
SASS_FOLDER=scss

aux_compile_elm() {
	echo "Compiling Elm..." &&
	elm make $SOURCE_FOLDER/Main.elm --optimize --output=$STATIC_FOLDER/$JS_FILE
}

minifying_js() {
	echo "Minifying JS..." &&
	(uglifyjs $STATIC_FOLDER/$JS_FILE --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$STATIC_FOLDER/$JS_MINIFIED_FILE)
}

compile_elm() {
	cp $SOURCE_FOLDER/Main.elm /tmp/.OldMain.elm

	aux_compile_elm && echo "" && minifying_js

	if [ "$1" == "watch" ]; then
		echo -e "\n\n\nEntered Watch mode"
		echo -e "Waiting for changes..."
		while true
		do
			cmp --silent $SOURCE_FOLDER/Main.elm /tmp/.OldMain.elm
			if [ $? -eq 1 ]; then
				aux_compile_elm && echo "" && minifying_js
				cp $SOURCE_FOLDER/Main.elm /tmp/.OldMain.elm
				echo -e "\n\n\nWaiting for changes..."
			fi
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
