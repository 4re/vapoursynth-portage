# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1 cmake

DESCRIPTION="Non-local means denoise filter, drop-in replacement of the venerable KNLMeansCL (CPU only)"
HOMEPAGE="https://github.com/Ichunjo/vapoursynth-nlm-ispc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Ichunjo/vapoursynth-nlm-ispc.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Ichunjo/vapoursynth-nlm-ispc/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE=""

RDEPEND+="
    dev-lang/ispc
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

S="${WORKDIR}/${P/vs/vapoursynth}"

src_prepare() {
    cmake_src_prepare
}

src_configure() {
    local mycmakeargs=(
		-DVAPOURSYNTH_INCLUDE_DIR="$(vapoursynth get-include)"
        -DCMAKE_INSTALL_PREFIX="$(vapoursynth get-plugin-dir)"
    )
    cmake_src_configure
}
