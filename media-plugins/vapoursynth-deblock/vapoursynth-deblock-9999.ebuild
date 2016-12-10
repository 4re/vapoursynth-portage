# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils multilib

DESCRIPTION="It does a deblocking of the picture, using the deblocking filter of h264"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Deblock"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	|| ( >=sys-devel/gcc-5.1.0 sys-devel/clang )
"

DOCS=( "README.md" )

pkg_pretend() {
	if tc-is-gcc && [[ $(gcc-major-version) -lt 5 ]]; then
		die "The active compiler needs to be gcc 5.x or clang"
	fi
}

src_configure() {
	autotools-utils_src_configure --libdir="/usr/$(get_libdir)/vapoursynth/"
}
