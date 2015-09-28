# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs git-r3 multilib

DESCRIPTION="A convenience wrapper for fmtconv"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=170633"
EGIT_REPO_URI="https://gist.github.com/c250a0dfefbfb113e925.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
	media-plugins/vapoursynth-fmtconv
"
DEPEND="${RDEPEND}
"

src_compile() {
	$(tc-getCC) \
		${CFLAGS} ${LDFLAGS} \
		-shared -fPIC -std=c99 \
		-Wall -Wextra -Wno-unused-parameter \
		$(pkg-config --cflags vapoursynth) \
		-o libfmtcwrap.so fmtcwrap.c || die "compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe libfmtcwrap.so
	dodoc readme.txt
}
