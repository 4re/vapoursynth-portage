# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="vctrans a plugin for transitions"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=172594"
SRC_URI="https://www.dropbox.com/s/cqsqjf04n58j38a/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}"

LIBNAME="libvctrans.so"
EXTRAFLAGS="-fPIC -shared -std=c++11"

src_prepare(){
	rm VSHelper.h VapourSynth.h || die
	eapply_user
}

src_compile(){
	printf "$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) vctrans.cpp"
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) vctrans.cpp || die "Build failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
