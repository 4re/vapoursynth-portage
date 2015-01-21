# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A filter for smoothing of fluctuations"
HOMEPAGE="https://github.com/dubhater/vapoursynth-fluxsmooth"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-fluxsmooth.git"

inherit git-2

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
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe .libs/libfluxsmooth.so
        dodoc readme.rst
}
