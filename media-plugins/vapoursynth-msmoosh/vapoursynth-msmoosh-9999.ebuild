# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils multilib

DESCRIPTION="MSmooth is a spatial smoother that doesn't touch edges, MSharpen tries to sharpen only edges"
HOMEPAGE="https://github.com/dubhater/vapoursynth-msmoosh"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

DOCS=( readme.rst )

src_configure() {
	autotools-utils_src_configure --libdir="/usr/$(get_libdir)/vapoursynth/"
}
