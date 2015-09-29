# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="VapourSynth port of FFT3DFilter"
HOMEPAGE="https://github.com/VFR-maniac/VapourSynth-FFT3DFilter"

EGIT_REPO_URI="https://github.com/VFR-maniac/${PN}.git"
EGIT_COMMIT="b023e21954423f29fdefcb54a6b0540deb3bdac4"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCC)\":" configure || die
}

src_configure() {
	./configure --prefix="${ROOT}/usr" --extra-cxxflags="${CXXFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}
