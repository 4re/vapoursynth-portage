# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="2D/3D frequency domain denoiser"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DFTTest"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0[threads]
"
DEPEND="${RDEPEND}
"

src_prepare() {
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCC)\":" \
		-e "s:LD=\"g++\":LD=\"$(tc-getCC)\":" configure || die
}

src_configure() {
	# We need -mno-avx here to fix compilation
	./configure \
		--install="${ED}/usr/$(get_libdir)/vapoursynth/" \
		--extra-cxxflags="${CXXFLAGS} -mno-avx" --extra-ldflags="${LDFLAGS}" || die "configure failed"
}

src_install() {
	emake install
	dodoc README.md
}
