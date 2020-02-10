# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="A plugin which operate on pixel values and modify it as per some criteria. Useful for denoising"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=171412"
SRC_URI="https://www.dropbox.com/s/it6gx663d3hevss/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}"

LIBNAME="libvcmod.so"
EXTRAFLAGS="-fPIC -shared -std=c++11"

src_prepare(){
	sed -i -e s/vapoursynth.h/VapourSynth.h/g -e s/vshelper.h/VSHelper.h/g *.cpp || die
	eapply_user
}

src_compile(){
	echo "$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) vcmod.cpp"
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) vcmod.cpp || die "Build failed"
}

src_install(){
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
}
