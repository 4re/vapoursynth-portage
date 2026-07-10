# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1

DESCRIPTION="MVUtensils is a refactoring of the original VapourSynth mvtools port"
HOMEPAGE="https://github.com/myrsloik/mvutensils"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/mvutensils.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/myrsloik/mvutensils/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	>=media-libs/zimg-3.0.5
	sci-libs/fftw:3.0
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/mvutensils-${PV}"

DOCS=( "readme.md" )

src_configure() {
	DISTUTILS_ARGS=(
		-Db_lto=$(usex lto true false)
	)
}
