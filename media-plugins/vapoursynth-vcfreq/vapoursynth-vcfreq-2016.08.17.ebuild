# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="A plugin that operates in frequency domain to filter out certain types of regular noises"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=171413"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=""
else
	SRC_URI="https://dl.dropboxusercontent.com/u/36232595/vapoursynth/${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}"

LIBNAME="libvcfreq.so"
COMMON_BUILD="-Wall -fPIC -shared -std=c++11"
COMMON_LINK="-shared -fPIC"

src_compile(){
	echo "$(tc-getCC) -c ${COMMON_BUILD} ${CFLAGS} -I. $(pkg-config --cflags vapoursynth) -o vcfreq.o vcfreq.cpp"
	$(tc-getCC) -c ${COMMON_BUILD} ${CFLAGS} -I. $(pkg-config --cflags vapoursynth) -o vcfreq.o vcfreq.cpp || die "Build failed"
	echo "$(tc-getCC) ${COMMON_LINK} $(pkg-config --libs fftw3f_threads) ${LDFLAGS} -o ${LIBNAME} vcfreq.o"
	$(tc-getCC) ${COMMON_LINK} $(pkg-config --libs fftw3f_threads) ${LDFLAGS} -o ${LIBNAME} vcfreq.o || die "Build failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
