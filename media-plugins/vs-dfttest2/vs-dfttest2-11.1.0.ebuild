# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
EGIT_SUBMODULES=( '*' )

inherit python-single-r1 cmake git-r3

DESCRIPTION="DFTTest re-implemetation (CUDA and x86)"
HOMEPAGE="https://github.com/Ichunjo/vs-dfttest2"

EGIT_REPO_URI="https://github.com/Ichunjo/vs-dfttest2.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

src_prepare() {
	default
	cp -v "${FILESDIR}/CMakeLists.txt" "${S}/" || die

	cmake_src_prepare
}

src_install() {
	insinto "$(vapoursynth get-plugin-dir)"
	doins "${BUILD_DIR}/libdfttest2_cpu.so"
	python_moduleinto dfttest2
	python_domodule python/*.py
}
