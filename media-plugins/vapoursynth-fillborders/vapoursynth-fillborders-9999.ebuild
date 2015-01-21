# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="VapourSynth filter that fills the borders of a clip, without changing the clip's dimensions."
HOMEPAGE="https://github.com/dubhater/vapoursynth-fillborders"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-fillborders.git"

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
        doexe .libs/libfillborders.so
}
