# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="Image reader plugin for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/vsimagereader"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/vsimagereader.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/myrsloik/vsimagereader/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
	media-libs/libpng:0
	media-libs/libjpeg-turbo
	sys-libs/zlib
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/src"

src_configure() {
	chmod +x configure
	./configure --enable-new-png --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}"
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe libvsimagereader.so
	dodoc ../readme.rst
}
