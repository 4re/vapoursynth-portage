# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1

DESCRIPTION="Field matcher and decimation filter for VapourSynth similar to TIVTC"
HOMEPAGE="https://github.com/vapoursynth/vivtc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/vivtc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/vapoursynth/vivtc/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

src_configure() {
	DISTUTILS_ARGS=(
		-Db_lto=$(usex lto true false)
	)
}
