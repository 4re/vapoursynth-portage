# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="Raw format video reader for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/vsrawsource"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/vsrawsource.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/myrsloik/vsrawsource/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	sed -i -e "s:CC=\"gcc\":CXX=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"gcc\":LD=\"$(tc-getCC)\":" configure || die
	./configure --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}"
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe libvsrawsource.so
	dodoc format_list.txt readme.rst
}
