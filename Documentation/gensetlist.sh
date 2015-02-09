#!/bin/bash

root="../"
categories="media-plugins"
packages=""

for category in ${categories}; do
	for package in $( ls -1 "${root}/${category}" ); do
		echo "${category}/${package}"
	done
done
