# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="BM3D denoising filter for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-debug"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCXX)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCXX)\":" configure || die

	if use debug; then
		myflags="--enable-debug"
	fi

	./configure \
		--install="${ED}/usr/$(get_libdir)/vapoursynth/" \
		--extra-cxxflags="${CXXFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		${myflags} || die "configure failed"
}

src_install() {
	emake install
	dodoc README.md
}
