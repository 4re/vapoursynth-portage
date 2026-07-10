# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1

DESCRIPTION="Extends the standard zimg resizer"
HOMEPAGE="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="lto"
RESTRICT="network-sandbox"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "ReadMe.md" )

src_configure() {
	DISTUTILS_ARGS=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure --wrap-mode=default
}
