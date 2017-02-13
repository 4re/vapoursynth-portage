# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Fix Telecined Fades"
HOMEPAGE="https://github.com/IFeelBloated/Fix-Telecined-Fades"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/Fix-Telecined-Fades"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/IFeelBloated/Fix-Telecined-Fades/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libftf.so"
COMMON_FLAGS="-Wall -std=c++14 -fPIC"


src_prepare(){
	rm VSHelper.h VapourSynth.h
	eapply_user
}

src_compile(){
	$(tc-getCC) ${CXXFLAGS} ${COMMON_FLAGS} $(pkg-config --cflags vapoursynth) -c -o Source.o Source.cpp || die "Building failed"
	$(tc-getCC) ${CXXFLAGS} -mfma ${COMMON_FLAGS} $(pkg-config --cflags vapoursynth) -c -o Source_AVX_FMA.o Source_AVX_FMA.cpp || die "Building failed"
	$(tc-getCC) ${CXXFLAGS} -shared ${COMMON_FLAGS} $(pkg-config --cflags vapoursynth) ${LDFLAGS} -o ${LIBNAME} Source.o Source_AVX_FMA.o || die "Linking failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
