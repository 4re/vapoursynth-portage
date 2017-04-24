# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="VapourSynth port of TNLMeans"
HOMEPAGE="https://github.com/VFR-maniac/VapourSynth-TNLMeans"

EGIT_REPO_URI="https://github.com/VFR-maniac/${PN}.git"
EGIT_COMMIT="22a40afaf78b6932800f552c43edc510da2d50a3"

LICENSE="LGPL-2.1"
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
