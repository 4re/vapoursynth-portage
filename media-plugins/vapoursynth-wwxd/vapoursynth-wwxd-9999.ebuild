# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="Xvid-like scene change detection for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-wwxd"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libwwxd.so"

src_compile() {
	$(tc-getCC) -shared -fPIC ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) src/wwxd.c src/detection.c || die "Build failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
	dodoc readme
}
