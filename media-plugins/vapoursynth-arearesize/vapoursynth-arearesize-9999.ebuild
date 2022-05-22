# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="AreaResize is an area average downscale resizer plugin for VapourSynth"
HOMEPAGE="https://github.com/Kiyamou/VapourSynth-AreaResize"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Kiyamou/VapourSynth-AreaResize.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Kiyamou/VapourSynth-AreaResize/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}"


src_configure(){
	EXTRAFLAGS="-fPIC -shared -std=c++17 $(pkg-config --cflags vapoursynth)"
	LIBNAME="libarearesize.so"
}

src_compile(){
	echo "$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} AreaResize/AreaResize.cpp"
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} AreaResize/AreaResize.cpp || die "Build failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
