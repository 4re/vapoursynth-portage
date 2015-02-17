#!/bin/bash

root="../"
categories="media-plugins"
setsfile="${root}/sets/vapoursynth-plugins"

[[ -f ${setsfile} ]] && rm -f ${setsfile}
for category in ${categories}; do
	for package in $( ls -1 "${root}/${category}" ); do
		echo "${category}/${package}" >> ${setsfile}
	done
done
