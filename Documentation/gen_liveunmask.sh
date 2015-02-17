#!/bin/bash

root="../"
categories="app-editors media-libs media-plugins media-video"
unmaskfile="${root}/Documentation/package.accept_keywords/vapoursynth-live"

[[ -f ${unmaskfile} ]] && rm -f ${unmaskfile}
for category in ${categories}; do
	for package in $( ls -1 "${root}/${category}" ); do
		echo "=${category}/${package}-9999 **" >> ${unmaskfile}
	done
done
