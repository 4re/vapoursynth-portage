# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="This plugin moves pixels as per requirement. Useful for correcting certain distortions or tilt or for transitions"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=171414"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=""
else
	SRC_URI="https://www.dropbox.com/s/2fku3g1b4smgrt3/${P}.tar.bz2"
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

LIBNAME="libvcmove.so"
EXTRAFLAGS="-fPIC -shared -std=c++11"

src_prepare(){
	rm VSHelper.h VapourSynth.h || die
	sed -i -e s/reformHelper.cpp/ReformHelper.cpp/g *.cpp || die
}

src_compile(){
	printf "$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) vcmove.cpp"
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) vcmove.cpp || die "Build failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
