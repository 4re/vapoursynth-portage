# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="VapourSynth port of TDeint and TMM"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TDeintMod"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TDeintMod.git"

inherit git-2 toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libtdeintmod.so"
ECFLAGS="-ffast-math -std=c++11 -Wall -DVS_TARGET_CPU_X86_64 -msse2 -fPIC -fexcess-precision=fast"
ELDFLAGS="-shared -Wl,-Bsymbolic -fPIC"
EINCLUDE="-I. -I./include"

#src_prepare() {
#        sed -i 's/..\\include\\//g' source/*.cpp || die "Prepare failed"
#        sed -i 's/vapoursynth\\//g' include/*.h source/*.cpp || die "Prepare failed"
#}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${ECFLAGS} ${EINCLUDE} $(pkg-config --cflags vapoursynth) -c TDeintMod/TDeintMod.cpp -o TDeintMod/TDeintMod.o || die "Build failed"
	$(tc-getCC) -o ${LIBNAME} ${LDFLAGS} ${ELDFLAGS} TDeintMod/TDeintMod.o -lvapoursynth || die "Linking failed"
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe ${LIBNAME}
        dodoc README.md LICENSE
}
