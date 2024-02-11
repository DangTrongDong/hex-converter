#!/bin/bash

# A simple hexadecimal to text and vice versa converter
# Use -d option to decrypt the hexadecimal
# Use -e option to encrypt the text
# If there is no option, the program will automatically choose to either decrypt or encrypt the input

if [[ $# -eq 0 || $1 == "-h" || $1 == "--help" ]]; then
	echo "Use -d option to decrypt the hexadecimal"
	echo "Use -e option to encrypt the text"
	echo "Use -v option to know the version"
elif [[ $1 == "-v" || $1 == "--version" ]]; then
	echo "v1.0.0"
else
	input=""

	for arg in "$@"; do
		if [[ $arg != "1" || ( $arg != "-e" && $arg != "-d" && $arg != "--encrypt" && $arg != "--decrypt" ) ]]; then	
			input+=" ${arg}"
		fi
	done

	input="${input:1}"

	if [[ $1 == "-d" || $1 == "--decrypt" || ( $1 != "-e" && $1 != "--encrypt" && $input =~ ^[a-fA-F0-9[:space:]]+$ ) ]]; then
		output="The original text: $(echo -n $input | xxd -r -p 2>NUL)"
	else
		output="The hexadecimal: $(echo -n $input | xxd -p 2>NUL)"
	fi

	output=$(echo -n "$output" | tr -d '\n')

	echo $output
fi