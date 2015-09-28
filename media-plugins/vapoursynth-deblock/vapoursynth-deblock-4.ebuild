# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="It does a deblocking of the picture, using the deblocking filter of h264"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Deblock"

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
"
DEPEND="${RDEPEND}
"

src_configure() {
	# No build system upstream
	selfcxxflags="-Wall -fPIC -std=c++11"
	selfldflags="-shared"
	libname="libdeblock.so"
}

src_compile() {
	echo "$(tc-getCXX) ${selfcxxflags} ${CXXFLAGS} ${selfldflags} ${LDFLAGS} -c src/*.cpp -o ${libname}"
	$(tc-getCXX) ${selfcxxflags} ${CXXFLAGS} ${selfldflags} ${LDFLAGS} src/*.cpp -o ${libname} || die
}

src_install() {
	exeinto "/usr/$(get_libdir)/vapoursynth/"
	doexe ${libname}
	dodoc README.md
}
