# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Modified version of Fizick's avisynth filter port of yadif from mplayer"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Yadifmod"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Yadifmod.git"

inherit git-2 toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_compile() {
	$(tc-getCC) -shared -fPIC -std=c++11 ${CFLAGS} ${LDFLAGS} -o libyadifmod.so $(pkg-config --cflags vapoursynth) Yadifmod/Yadifmod.cpp || die "Build failed"
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe libyadifmod.so
        dodoc README.md
}
