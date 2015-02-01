# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 toolchain-funcs

DESCRIPTION="A wavelet based denoiser"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VagueDenoiser"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-VagueDenoiser.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
    media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libvaguedenoiser.so"
INSTALLDIR="/usr/lib/vapoursynth/"

src_configure() {
    ./configure --install="${INSTALLDIR}" --extra-cxxflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_install() {
    exeinto ${INSTALLDIR}
    doexe ${LIBNAME} || die
    dodoc README.md LICENSE || die
}
