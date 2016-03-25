#!/bin/bash

root="../"
meta_cat="media-plugins"
meta_ebuild_iuse="$(mktemp)"
meta_ebuild_dep="$(mktemp)"

mheader() {
cat << EOF
# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# \$Id\$

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

for category in ${meta_cat}; do
	for package in $( ls -1 "${root}/${category}" ); do
		if [ "${package}" != "vapoursynth-plugins-meta" ]; then
			echo -e "\tvapoursynth_plugins_${package#vapoursynth-}"  >> ${meta_ebuild_iuse}
			echo -e "\tvapoursynth_plugins_${package#vapoursynth-}? ( ${category}/${package} )"  >> ${meta_ebuild_dep}
		fi
	done
done

mheader
cat "${meta_ebuild_iuse}"
mbody
cat "${meta_ebuild_dep}"
mtail
