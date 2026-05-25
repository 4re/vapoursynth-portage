# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1 git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/End-of-Eternity/vs-ccd"

EGIT_REPO_URI="https://github.com/End-of-Eternity/vs-ccd.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

src_prepare() {
	default
	cp "${FILESDIR}/meson.build" "${S}"|| die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_domodule ccd.py
}
