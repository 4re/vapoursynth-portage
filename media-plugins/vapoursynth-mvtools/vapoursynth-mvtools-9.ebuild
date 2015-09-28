# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils multilib

DESCRIPTION="MVTools is a set of filters for motion estimation and compensation"
HOMEPAGE="https://github.com/dubhater/vapoursynth-mvtools"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0
"
DEPEND="${RDEPEND}
"

DOCS=( readme.rst )

src_configure() {
	autotools-utils_src_configure --libdir="/usr/$(get_libdir)/vapoursynth/"
}
