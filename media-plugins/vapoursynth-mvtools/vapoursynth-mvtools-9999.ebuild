# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="MVTools is a set of filters for motion estimation and compensation"
HOMEPAGE="https://github.com/dubhater/vapoursynth-mvtools"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-mvtools.git"
# EGIT_COMMIT="022c7712380adef9625d137e77598e701244953d"

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
	doexe .libs/libmvtools.so
}
