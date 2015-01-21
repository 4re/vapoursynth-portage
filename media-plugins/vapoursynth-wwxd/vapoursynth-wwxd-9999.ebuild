# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="Xvid-like scene change detection for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-wwxd"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-wwxd.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_compile() {
	$(tc-getCC) -shared -fPIC ${CFLAGS} ${LDFLAGS} -o libwwxd.so $(pkg-config --cflags vapoursynth) src/wwxd.c src/detection.c || die "Build failed"
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	doexe libwwxd.so
	dodoc readme
}
