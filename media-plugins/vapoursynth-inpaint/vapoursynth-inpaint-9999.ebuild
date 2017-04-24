# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="VapourSynth plugin for image inpaintin"
HOMEPAGE="https://github.com/invisiblearts/VapourSynth-Inpaint"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/invisiblearts/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/invisiblearts/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE=""
KEYWORDS=""
IUSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	media-libs/opencv
"
DEPEND="${RDEPEND}
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-fix-include.patch"
}

src_configure() {
	# No build system upstream
	selfcflags="-Wall -fPIC -std=c++11"
	selfldflags="-shared"
	libname="libinpaint.so"
}

src_compile() {
	echo "$(tc-getCC) ${selfcflags} ${CFLAGS} $(pkg-config --cflags vapoursynth) -c Inpaint.cpp -o Inpaint.o"
	$(tc-getCC) ${selfcflags} ${CFLAGS} $(pkg-config --cflags vapoursynth) -c Inpaint.cpp -o Inpaint.o || die

	echo "$(tc-getCC) ${CFLAGS} ${selfldflags} ${LDFLAGS} Inpaint.o $(pkg-config --libs opencv) -o ${libname}"
	$(tc-getCC) ${CFLAGS} ${selfldflags} ${LDFLAGS} Inpaint.o $(pkg-config --libs opencv) -o ${libname} || die
}

src_install() {
	exeinto "/usr/$(get_libdir)/vapoursynth/"
	doexe ${libname}
	dodoc README.md
}
