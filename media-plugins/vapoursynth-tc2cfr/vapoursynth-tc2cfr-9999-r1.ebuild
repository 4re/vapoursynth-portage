# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multilib

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

PATCHES=( "${FILESDIR}/${P}-includes.patch" )

SOURCEFILES="VSFrontend.cpp Backend.cpp"
LIBNAME="libtc2cfr.so"
EXTRAFLAGS="-fPIC -shared"


src_compile() {
	$(tc-getCC) ${CXXFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) ${SOURCEFILES} || die "Build failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME} || die
	if use doc; then
		dodoc README.md || die
	fi
}
