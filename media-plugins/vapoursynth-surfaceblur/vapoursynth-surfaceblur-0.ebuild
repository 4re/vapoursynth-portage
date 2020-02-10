# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="Surface Blur"
HOMEPAGE="https://github.com/MoePus/VapourSynth-surfaceBlur"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MoePus/VapourSynth-surfaceBlur.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/MoePus/VapourSynth-surfaceBlur/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE="cpu_flags_x86_avx"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libsurfaceblur.so"
COMMON_FLAGS="-std=c++11 -shared -fPIC"

src_configure() {
    if ! use cpu_flags_x86_avx ; then
        echo "" > config.h
    else
        COMMON_FLAGS+=" -mavx"
    fi
}

src_compile() {
	echo "$(tc-getCXX) ${CXXFLAGS} ${COMMON_FLAGS} ${LDFLAGS} $(pkg-config --cflags vapoursynth) -I. VSPlugin.cpp -o ${LIBNAME}"
	$(tc-getCXX) ${CXXFLAGS} ${COMMON_FLAGS} ${LDFLAGS} $(pkg-config --cflags vapoursynth) -I. VSPlugin.cpp -o ${LIBNAME} || die
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
	dodoc readme.md
}
