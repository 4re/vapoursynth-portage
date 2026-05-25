# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python
EGIT_SUBMODULES=( '*' )

inherit distutils-r1 git-r3

DESCRIPTION="Raw video reader library and VapourSynth frontend"
HOMEPAGE="https://github.com/sekrit-twc/rawz"

EGIT_REPO_URI="https://github.com/sekrit-twc/rawz.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/r${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="WTFPL"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.rst" )

src_prepare() {
	default
	cp ${FILESDIR}/meson.build "${S}" || die
	cp ${FILESDIR}/pyproject.toml "${S}" || die
	cp ${FILESDIR}/COPYING "${S}" || die
}

src_configure() {
	DISTUTILS_ARGS=(
		-Db_lto=$(usex lto true false)
	)
}
