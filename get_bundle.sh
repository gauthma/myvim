#!/bin/bash

while read -r line ; do
	# skip blank or empty lines
	if [ -z "$line" -o "$line" == " " ]; then
		continue
	fi
	# skip comment lines...
	if [[ $line =~ ^\" ]]; then
		continue
	fi
	cd ~/.vim/bundle
	echo "Cloning $line..."
	git clone $line
done < "$1"

echo "Now run :Helptags() from within vim!"
