# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="A rewrite version of AVISynth SangNom2"
HOMEPAGE="https://bitbucket.org/James1201/vapoursynth-sangnom"

if [[ ${PV} == *9999* ]]; then
	inherit mercurial
	EHG_REPO_URI="https://bitbucket.org/James1201/${PN}"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://bitbucket.org/James1201/${PN}/get/r${PV}.tar.bz2 -> ${PN}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc cpu_flags_x86_sse4_1"
REQUIRED_USE="cpu_flags_x86_sse4_1"

RDEPEND+="
	!media-plugins/vapoursynth-sangnommod
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	cflags="-Wall -fPIC -shared -std=c++11 -msse4.1"
	libname="libsangnom.so"
}

src_compile() {
	echo "$(tc-getCC) ${cflags} ${CFLAGS} $(pkg-config --cflags vapoursynth) sangnom_c.cpp -o ${libname}"
	$(tc-getCC) ${cflags} ${CFLAGS} $(pkg-config --cflags vapoursynth) sangnom_c.cpp -o ${libname} || die
}

src_install() {
	use doc && DOCS=( "${WORKDIR}/${P}/README.md" ) && einstalldocs
	exeinto "/usr/$(get_libdir)/vapoursynth/"
	doexe ${libname}
}
