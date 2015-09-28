# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="vcmod is a plugin for vapoursynth with several functions which essentially operate on pixel values and modify it as per some criteria. Useful for denoising"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=171412&highlight=vcmod"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=""
else
	SRC_URI="https://dl.dropboxusercontent.com/u/36232595/vapoursynth/${P}.7z"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	app-arch/p7zip
"

S="${WORKDIR}"

LIBNAME="libvcmod.so"
EXTRAFLAGS="-fPIC -shared -std=c++11"

src_prepare(){
	rm VSHelper.h VapourSynth.h || die
	sed -i -e s/vapoursynth.h/VapourSynth.h/g -e s/vshelper.h/VSHelper.h/g *.cpp || die
}

src_compile(){
	printf "$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) vcmod.cpp"
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) vcmod.cpp || die "Build failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
