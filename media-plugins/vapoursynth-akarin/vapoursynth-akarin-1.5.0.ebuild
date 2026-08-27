# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {16..22} )
PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 git-r3 meson llvm-r1

DESCRIPTION="Akarin's experimental VapourSynth plugin"
HOMEPAGE="https://github.com/Jaded-Encoding-Thaumaturgy/akarin-vapoursynth-plugin"
EGIT_REPO_URI="https://github.com/Jaded-Encoding-Thaumaturgy/akarin-vapoursynth-plugin.git"

if ver_test ${PV} -ne 9999; then
	EGIT_COMMIT="refs/tags/v${PV}"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="
	${RDEPEND}
	$(llvm_gen_dep 'llvm-core/llvm:${LLVM_SLOT}=')
"

src_configure() {
	default
	local emesonargs=(
		-Dstatic-llvm=false
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}

src_install() {
	default
	insinto "$(vapoursynth get-plugin-dir)"
	doins "${BUILD_DIR}/libakarin.so" || die
}
