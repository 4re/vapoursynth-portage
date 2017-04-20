# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs

DESCRIPTION="AutoCrop for Vapoursynth"
HOMEPAGE="https://github.com/Infiziert90/vapoursynth-autocrop"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Infiziert90/vapoursynth-autocrop.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Infiziert90/vapoursynth-autocrop/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libautocrop.so"
COMMON_FLAGS="-Wall -fPIC -shared -std=c++98 -shared -fPIC"

src_compile(){
	echo "$(tc-getCC) ${COMMON_FLAGS} ${CFLAGS} $(pkg-config --cflags vapoursynth) -o ${LIBNAME} autocrop.cpp"
	$(tc-getCC) ${COMMON_FLAGS} ${CFLAGS} $(pkg-config --cflags vapoursynth) -o ${LIBNAME} autocrop.cpp || die "Build failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
