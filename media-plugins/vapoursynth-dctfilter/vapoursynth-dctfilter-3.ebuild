# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="Performs DCT on 8x8 blocks of source clip, applies modification to it, then performs IDCT"
HOMEPAGE="https://bitbucket.org/mystery_keeper/vapoursynth-dctfilter"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/mystery_keeper/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://bitbucket.org/mystery_keeper/${PN}/get/r${PV}.tar.bz2 -> ${PN}-${PV}.tar.bz2"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	# No build system upstream
	selfcflags="-Wall -fPIC"
	selfldflags="-shared"
	libname="libdctfilter.so"
}

src_compile() {
	echo "$(tc-getCC) ${selfcflags} ${CFLAGS} -c src/croutines.c -o src/croutines.o"
	$(tc-getCC) ${selfcflags} ${CFLAGS} -c src/croutines.c -o src/croutines.o || die

	echo "$(tc-getCC) ${selfcflags} ${CFLAGS} -c src/main.c -o src/main.o"
	$(tc-getCC) ${selfcflags} ${CFLAGS} -c src/main.c -o src/main.o || die

	echo "$(tc-getCC) ${selfldflags} ${LDFLAGS} src/*.o -o ${libname}"
	$(tc-getCC) ${selfldflags} ${LDFLAGS} src/*.o -o ${libname} || die
}

src_install() {
	exeinto "/usr/$(get_libdir)/vapoursynth/"
	doexe ${libname}
	dodoc README
}
