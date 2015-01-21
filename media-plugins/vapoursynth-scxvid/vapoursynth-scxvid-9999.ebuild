# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="Scene change detection plugin for VapourSynth, using XviD"
HOMEPAGE="https://github.com/dubhater/vapoursynth-scxvid"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-scxvid.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
    media-libs/vapoursynth
    media-libs/xvid
"
DEPEND="${RDEPEND}
"

src_prepare() {
    ./autogen.sh || die
}

src_install() {
    exeinto /usr/lib/vapoursynth/
    dodoc readme.rst
    doexe .libs/libscxvid.so
}
