# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=no

inherit distutils-r1 git-r3

DESCRIPTION="Optimized nnedi3 filter"
HOMEPAGE="https://github.com/sekrit-twc/znedi3"
EGIT_REPO_URI="https://github.com/sekrit-twc/znedi3.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/r${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_compile() {
	emake CPPFLAGS="-DNNEDI3_WEIGHTS_PATH=\\\"\"${EROOT}/usr/share/znedi3/nnedi3_weights.bin\"\\\"" X86=1
}

src_install() {
	insinto "$(vapoursynth get-plugin-dir)"
	doins vsznedi3.so
	insinto "/usr/share/znedi3"
	doins nnedi3_weights.bin
}
