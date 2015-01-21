# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="CombMask plugin for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/CombMask"
EGIT_REPO_URI="https://github.com/chikuzen/CombMask.git"

inherit git-2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	cd vapoursynth/src
	chmod +x configure
	./configure --install="/usr/lib/vapoursynth" --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_compile() {
	cd vapoursynth/src
	emake || die
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe vapoursynth/src/libcombmask.so
	dodoc vapoursynth/readme.rst
}
