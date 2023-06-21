# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A fork of flash3kyuu_deband"
HOMEPAGE="https://github.com/HomeOfAviSynthPlusEvolution/neo_f3kdb"

EGIT_REPO_URI="https://github.com/HomeOfAviSynthPlusEvolution/neo_f3kdb.git"

if ver_test ${PV} -ne 9999; then
	EGIT_COMMIT="r${PV}"
	KEYWORDS="~x86 ~amd64"
else
	KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth
	dev-cpp/tbb
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	cmake_src_prepare

	# Fix for neo_f3kdb's CMakeLists
	ln -s "${S}/.git" "${BUILD_DIR}/.git" || die
}

src_configure() {
	# CMakeLists uses git to grab version info
	export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

	cmake_src_configure
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe "${BUILD_DIR}/libneo-f3kdb.so"
}
