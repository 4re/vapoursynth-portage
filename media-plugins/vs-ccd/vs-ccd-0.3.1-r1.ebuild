# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit meson python-single-r1 git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/End-of-Eternity/vs-ccd"

EGIT_REPO_URI="https://github.com/End-of-Eternity/vs-ccd.git"
EGIT_COMMIT="4256058f08786cdac9585e803c75453a18a7878e"
KEYWORDS="~amd64"

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )


src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}


src_install() {
	meson_src_install
	python_domodule ccd.py
}
