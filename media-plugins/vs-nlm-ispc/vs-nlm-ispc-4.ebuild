# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1 cmake

DESCRIPTION="Non-local means denoise filter, drop-in replacement of the venerable KNLMeansCL (CPU only)"
HOMEPAGE="https://github.com/AmusementClub/vs-nlm-ispc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AmusementClub/vs-nlm-ispc.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/AmusementClub/vs-nlm-ispc/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE=""

RDEPEND+="
    dev-lang/ispc
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP},legacy]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

src_prepare() {
    sed -i 's|cmake_path(APPEND install_dir ${VS_LIBDIR} vapoursynth)|set(install_dir ${CMAKE_INSTALL_PREFIX})|' CMakeLists.txt || die
    cmake_src_prepare
}

src_configure() {
    local mycmakeargs=(
        -DCMAKE_INSTALL_PREFIX="$(vapoursynth get-plugin-dir)"
    )
    cmake_src_configure
}
