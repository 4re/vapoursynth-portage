#!/bin/bash

root="../"
pack_cat="app-editors media-libs media-plugins media-video"
keywordsfile="${root}/Documentation/package.accept_keywords/vapoursynth"
unmaskfile="${root}/Documentation/package.accept_keywords/vapoursynth-live"

[[ -f ${keywordsfile} ]] && rm -f ${keywordsfile}
[[ -f ${unmaskfile} ]] && rm -f ${unmaskfile}

for category in ${pack_cat}; do
	for package in $( ls -1 "${root}/${category}" ); do
		echo "${category}/${package} ~*" >> ${keywordsfile}
		echo "~${category}/${package}-9999 **" >> ${unmaskfile}
	done
done

# ==================================================================================================

meta_ebuild_cat="media-plugins"
meta_ebuild_name="vapoursynth-plugins-meta"
meta_ebuild_iuse="$(mktemp)"
meta_ebuild_dep="$(mktemp)"
meta_ebuild_path="${root}/${meta_ebuild_cat}/${meta_ebuild_name}/"

version_increase() {
    MAX=0

    for i in $(ls -1 ${meta_ebuild_path}*ebuild); do
        i=${i##*vapoursynth-plugins-meta-}
        i=${i%%-r*}
        i=${i%%.ebuild*}
        (( $i > $MAX )) && MAX=$i
    done

    let ++MAX

    echo $MAX
}

mheader() {
cat << EOF
# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="VapourSynth plugins meta package."
HOMEPAGE="http://www.vapoursynth.com/"

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE="
EOF
}

mbody() {
cat << EOF
"

RDEPEND+=""
DEPEND="\${RDEPEND}
EOF
}

mtail() {
cat << EOF
"
EOF
}

for category in ${meta_ebuild_cat}; do
	for package in $( ls -1 "${root}/${category}" ); do
		if [ "${package}" != "vapoursynth-plugins-meta" ]; then
			echo -e "\tvapoursynth_plugins_${package#vapoursynth-}"  >> ${meta_ebuild_iuse}
			echo -e "\tvapoursynth_plugins_${package#vapoursynth-}? ( ${category}/${package} )"  >> ${meta_ebuild_dep}
		fi
	done
done

new_ebuild_full_path="${meta_ebuild_path}${meta_ebuild_name}-$(version_increase).ebuild"

mheader > $new_ebuild_full_path
cat "${meta_ebuild_iuse}" >> $new_ebuild_full_path
mbody >> $new_ebuild_full_path
cat "${meta_ebuild_dep}" >> $new_ebuild_full_path
mtail >> $new_ebuild_full_path
