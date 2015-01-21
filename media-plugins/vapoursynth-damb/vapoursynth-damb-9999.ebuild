# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 autotools

DESCRIPTION="Basic audio support for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-damb"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-damb.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/libsndfile
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	./autogen.sh || die
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	dodoc readme.rst
	doexe .libs/libdamb.so
}
