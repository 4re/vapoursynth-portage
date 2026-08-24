# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1

DESCRIPTION="TFM and TDecimate functions for field matching and decimation"
HOMEPAGE="https://github.com/dubhater/vapoursynth-tivtc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-tivtc"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-tivtc/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_configure() {
	DISTUTILS_ARGS=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
