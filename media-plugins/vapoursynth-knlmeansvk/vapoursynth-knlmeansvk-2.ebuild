# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1

DESCRIPTION="A Non-local means de-noising filter for VapourSynth using Vulkan"
HOMEPAGE="https://github.com/myrsloik/vapoursynth-knlmeansvk"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/vapoursynth-knlmeansvk.git"
else
	SRC_URI="https://github.com/myrsloik/vapoursynth-knlmeansvk/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="mirror"
IUSE="lto"

RDEPEND+="
	dev-util/vulkan-headers
	media-libs/shaderc
	>=media-libs/vapoursynth-80[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_configure() {
        DISTUTILS_ARGS=(
                -Db_lto=$(usex lto true false)
        )
}
