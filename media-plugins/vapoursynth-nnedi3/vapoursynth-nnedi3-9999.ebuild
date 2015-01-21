# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="nnedi3 is an intra-field only deinterlacer"
HOMEPAGE="https://github.com/dubhater/vapoursynth-nnedi3"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-nnedi3.git"

inherit git-2 flag-o-matic

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	./autogen.sh
	append-cflags -fno-strict-aliasing
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	dodoc readme.rst
	doexe .libs/libnnedi3.so
}
