# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="AddGrain generates film like grain or other effects (like rain) by adding random noise to a video clip"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain.git"

inherit git-2 toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libaddgrain.so"

src_compile() {
	$(tc-getCC) -shared -fPIC -std=c++11 ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) AddGrain/AddGrain.cpp || die "Build failed"
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe ${LIBNAME}
        dodoc README.md LICENSE
}
