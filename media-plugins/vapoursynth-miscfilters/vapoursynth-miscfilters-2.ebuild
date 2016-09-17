# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Miscellaneous vapoursynth filters to test"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=173871"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=""
	KEYWORDS=""
else
	SRC_URI="https://dl.dropboxusercontent.com/u/36232595/vapoursynth/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libmiscfilters.so"
EXTRAFLAGS="-fPIC -shared -std=c++11"


src_compile(){
	printf "$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) -I. misc.cpp"
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) -I. misc.cpp || die "Build failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
