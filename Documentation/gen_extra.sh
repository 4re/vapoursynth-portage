#!/bin/bash

root="../"
pack_cat="app-editors media-libs media-plugins media-video"
set_cat="media-plugins"
keywordsfile="${root}/Documentation/package.accept_keywords/vapoursynth"
unmaskfile="${root}/Documentation/package.accept_keywords/vapoursynth-live"
setsfile="${root}/sets/vapoursynth-plugins"

[[ -f ${keywordsfile} ]] && rm -f ${keywordsfile}
[[ -f ${unmaskfile} ]] && rm -f ${unmaskfile}
[[ -f ${setsfile} ]] && rm -f ${setsfile}

for category in ${pack_cat}; do
	for package in $( ls -1 "${root}/${category}" ); do
		echo "${category}/${package} ~*" >> ${keywordsfile}
		echo "~${category}/${package}-9999 **" >> ${unmaskfile}
	done
done

for category in ${set_cat}; do
	for package in $( ls -1 "${root}/${category}" ); do
		if [ "${package}" != "vapoursynth-plugins-meta" ]; then
			echo "${category}/${package}" >> ${setsfile}
        fi
	done
done
