# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit git-2

DESCRIPTION="VapourSynth port of FFT3DFilter"
HOMEPAGE="https://github.com/VFR-maniac/VapourSynth-FFT3DFilter"
EGIT_REPO_URI="https://github.com/VFR-maniac/VapourSynth-FFT3DFilter.git"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

RDEPEND+="
    media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
    ./configure --extra-cxxflags="${CXXFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	mv vsfft3dfilter.so.?? vsfft3dfilter.so || die
	doexe vsfft3dfilter.so || die
    dodoc LICENSE
}
