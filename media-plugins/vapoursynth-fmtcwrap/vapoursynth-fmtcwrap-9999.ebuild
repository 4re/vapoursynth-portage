# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="A convenience wrapper for fmtconv"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=170633"
EGIT_REPO_URI="https://gist.github.com/c250a0dfefbfb113e925.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#REV=8
#S="/var/tmp/portage/media-plugins/vapoursynth-fmtconv-${REV}/work/src" #FIXME

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
		-o libfmtcwrap.so fmtcwrap.c $(pkg-config --cflags vapoursynth) || die "compile failed"
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	doexe libfmtcwrap.so
	dodoc readme.txt
}
