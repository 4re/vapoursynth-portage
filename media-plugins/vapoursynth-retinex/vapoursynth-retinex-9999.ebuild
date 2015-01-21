# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="Retinex plugin for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Retinex"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Retinex.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libretinex.so"

src_prepare() {
	sed -i 's/..\\include\\//g' source/*.cpp || die "Prepare failed"
	sed -i 's/vapoursynth\\//g' include/*.h source/*.cpp || die "Prepare failed"
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -Wall -shared -fPIC -fpermissive -std=c++11 -o ${LIBNAME} -I./include $(pkg-config --cflags vapoursynth) -lvapoursynth source/*.cpp || die "Build failed"
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	doexe ${LIBNAME}
	dodoc README.md LICENSE
}
