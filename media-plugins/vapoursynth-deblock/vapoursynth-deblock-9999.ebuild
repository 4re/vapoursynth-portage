# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="It does a deblocking of the picture, using the deblocking filter of h264"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Deblock"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Deblock.git"

inherit git-2 toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libdeblock.so"

src_compile() {
	$(tc-getCC) -shared -fPIC ${CFLAGS} ${LDFLAGS} -std=c++11 -o ${LIBNAME} $(pkg-config --cflags vapoursynth) src/Deblock.cpp || die "Build failed"
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe ${LIBNAME}
        dodoc README.md
}
