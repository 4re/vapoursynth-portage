# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 toolchain-funcs

DESCRIPTION="EEDI2 is an vertical resizer intended for edge-directed interpolation for deinterlacing"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI2"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI2.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libeedi2.so"
INSTALLDIR="/usr/lib/vapoursynth/"

src_configure() {
    chmod +x configure
    ./configure --install="${INSTALLDIR}" --extra-cxxflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}"
}

src_install() {
        exeinto ${INSTALLDIR}
        doexe ${LIBNAME}
        dodoc README.md
}
