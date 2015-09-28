# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib eutils

DESCRIPTION="Plugin that can read a timecode file and convert a given video clip into one with constant framerate"
HOMEPAGE="https://github.com/gnaggnoyil/tc2cfr"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gnaggnoyil/tc2cfr.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/gnaggnoyil/tc2cfr/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

SOURCEFILES="AVSFrontend.cpp VSFrontend.cpp Backend.cpp"
LIBNAME="tc2cfr.so"

src_prepare() {
	epatch "${FILESDIR}/${P}-includes.patch" || die
}

src_compile() {
	for i in ${SOURCEFILES}; do
		echo "$(tc-getCXX) ${CFLAGS} ${LDFLAGS} -shared -fPIC $(pkg-config --cflags vapoursynth) -o ${i%.*}.o ${i}"
		$(tc-getCXX) \
			${CFLAGS} ${LDFLAGS} -shared -fPIC \
			$(pkg-config --cflags vapoursynth) \
			-o ${i%.*}.o ${i} || die "compile failed"
	done
	echo "$(tc-getCXX) ${LDFLAGS} -shared -o ${LIBNAME} *.o"
	$(tc-getCXX) \
			${LDFLAGS} -shared \
			-o ${LIBNAME} *.o || die "linking failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME} || die
	if use doc; then
		dodoc README.md || die
	fi
}
