# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Median filter for VapourSynth (the same algorithm that MedianBlur2)"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CTMF"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CTMF.git"

inherit git-2 toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libctmf.so"

src_compile() {
	$(tc-getCC) -shared -fPIC -std=c++11 ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) CTMF/CTMF.cpp || die "Build failed"
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe ${LIBNAME}
        dodoc README.md
}
