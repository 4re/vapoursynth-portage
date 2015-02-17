#!/bin/bash

root="../"
categories="app-editors media-libs media-plugins media-video"
keywordsfile="${root}/Documentation/package.accept_keywords/vapoursynth"

[[ -f ${keywordsfile} ]] && rm -f ${keywordsfile}
for category in ${categories}; do
	for package in $( ls -1 "${root}/${category}" ); do
		echo "${category}/${package} ~*" >> ${keywordsfile}
	done
done
