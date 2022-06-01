# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit meson flag-o-matic python-single-r1

DESCRIPTION="Spatial derainbow filter"
HOMEPAGE="https://github.com/dubhater/vapoursynth-smoothuv"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

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
