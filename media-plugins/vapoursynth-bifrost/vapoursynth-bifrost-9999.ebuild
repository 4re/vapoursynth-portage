# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Decrawler plugin for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-bifots"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-bifrost.git"

inherit git-2 autotools

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	./autogen.sh || die
}

#src_configure() {
#	cd src
#	./configure --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
#}

#src_compile() {
#	cd src
#	emake || die
#}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe .libs/libbifrost.so
}
