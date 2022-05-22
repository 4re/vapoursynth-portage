# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit meson flag-o-matic git-r3 python-single-r1

DESCRIPTION="Spatial derainbow filter"
HOMEPAGE="https://github.com/dubhater/vapoursynth-smoothuv"

EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
EGTI_COMMIT="d75886e6876c7ec45010cc735d69985bab3936df"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
	media-plugins/vapoursynth-kagefunc
	media-plugins/vapoursynth-tcanny
"
DEPEND="${RDEPEND}
"

DOCS=( "readme.rst" )


src_configure() {
	append-cxxflags $(test-flags-CXX -fpeel-loops)
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}

src_install(){
	meson_src_install
	python_domodule RainbowSmooth.py
}
