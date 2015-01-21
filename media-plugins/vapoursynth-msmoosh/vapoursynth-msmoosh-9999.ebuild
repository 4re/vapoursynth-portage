# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="MSmooth is a spatial smoother that doesn't touch edges, MSharpen tries to sharpen only edges"
HOMEPAGE="https://github.com/dubhater/vapoursynth-msmoosh"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-msmoosh.git"

inherit git-2 autotools

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
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
	doexe .libs/libmsmoosh.so
}
