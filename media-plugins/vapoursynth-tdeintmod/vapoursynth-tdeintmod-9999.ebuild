# Copyright 1999-2015 Gentoo Foundation
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
INSTALLDIR="/usr/lib/vapoursynth/"

src_configure() {
    chmod +x configure
    ./configure --install="${INSTALLDIR}" --extra-cxxflags="${CFLAGS} -mno-avx" --extra-ldflags="${LDFLAGS}"
}

src_install() {
        exeinto ${INSTALLDIR}
        doexe ${LIBNAME}
        dodoc README.md LICENSE
}
