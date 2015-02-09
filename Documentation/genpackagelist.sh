#!/bin/bash

mhelp() {
cat << EOF
${0##*/}
Need one argument:
	k	Generate package accept keywords for current tree
	u	Generate package unmask for current tree

Usage: ${0##*/} <argument>
EOF
}

if [[ $# != 1 ]]; then
	mhelp
	exit
fi

root="../"
categories="app-editors media-libs media-plugins media-video"
packages=""

for category in ${categories}; do
	for package in $( ls -1 "${root}/${category}" ); do
		if [[ $1 == "k" ]]; then
			echo "${category}/${package}"
		elif [[ $1 == "u" ]]; then
			echo "=${category}/${package}-9999 **"
		else
			echo "Invalid argument"
			mhelp
			exit
		fi
	done
done
