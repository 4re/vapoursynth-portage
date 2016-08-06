# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="A deinterlace / antialiasing plugin for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-SangNomMod"
# v0.1 produces broken output
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
EGIT_COMMIT="b17bb98bfb348ae557651f83f3659c45dcc5bbec"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	!media-plugins/vapoursynth-sangnom
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	sed -i -e "s:CXX=\"clang++\":CXX=\"$(tc-getCXX)\":" configure || die
	sed -i -e "s:LD=\"clang++\":LD=\"$(tc-getCXX)\":" configure || die
	chmod +x configure
	./configure \
		--install="${ED}/usr/$(get_libdir)/vapoursynth/" \
		--extra-cxxflags="${CXXFLAGS}" --extra-ldflags="${LDFLAGS}" || die "configure failed"
}

src_install() {
	emake install
	dodoc README.md
}
