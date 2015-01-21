# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="Performs DCT on 8x8 blocks of source clip, applies modification to it, then performs IDCT"
HOMEPAGE="https://bitbucket.org/mystery_keeper/vapoursynth-dctfilter"
EGIT_REPO_URI="https://bitbucket.org/mystery_keeper/vapoursynth-dctfilter.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

USFLAGS="-shared -fPIC"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} ${USFLAGS} -o libdctfilter.so -Isrc $(pkg-config --cflags vapoursynth) src/croutines.c src/main.c || die "Build failed"
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	doexe libdctfilter.so
	dodoc README
}
