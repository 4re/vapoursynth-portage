# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="Image reader plugin for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/vsimagereader"

EGIT_REPO_URI="https://github.com/myrsloik/vsimagereader.git"
EGIT_COMMIT="7c7328dae5a0b99c79c1fc6a7282ee61f6532e51"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

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
