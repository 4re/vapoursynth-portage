# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Image reader plugin for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/vsimagereader"
EGIT_REPO_URI="https://github.com/myrsloik/vsimagereader.git"
#EGIT_REPO_URI="https://github.com/chikuzen/vsimagereader.git"

inherit git-2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
	>=media-libs/libpng-1.4
	media-libs/libjpeg-turbo
	sys-libs/zlib
"
DEPEND="${RDEPEND}
"

src_prepare() {
	chmod +x src/configure
}

src_configure() {
	cd src
	./configure --enable-new-png --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}"
}

src_compile() {
	cd src
	emake || die
}

src_install() {
	cd src/
        exeinto /usr/lib/vapoursynth/
        doexe libvsimagereader.so
}
