# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="VapourSynth port of DePan"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DePan"

EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
EGIT_COMMIT="e248fa9c61e0b4ef50fbc655ee49638df5eb0adc"

KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0
"
DEPEND="${RDEPEND}
"

src_configure() {
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCXX)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCXX)\":" configure || die
	chmod +x configure
	./configure \
		--install="${ED}/usr/$(get_libdir)/vapoursynth/" \
		--extra-cxxflags="${CXXFLAGS}" --extra-ldflags="${LDFLAGS}" || die "configure failed"
}

src_install() {
	emake install
	dodoc README.md
}
