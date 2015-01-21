# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="EEDI2 is an vertical resizer intended for edge-directed interpolation for deinterlacing"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI2"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI2.git"

inherit git-2 toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libeedi2.so"

src_compile() {
	$(tc-getCC) -shared -fPIC -std=c++11 ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) EEDI2/EEDI2.cpp || die "Build failed"
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe ${LIBNAME}
        dodoc README.md
}
