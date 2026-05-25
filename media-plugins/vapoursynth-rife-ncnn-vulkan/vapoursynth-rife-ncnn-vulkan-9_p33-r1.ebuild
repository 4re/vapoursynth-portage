# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1

MY_PV=${PV%%_p*}
PATCH=${PV#*_p}

DESCRIPTION="Real-Time Intermediate Flow Estimation for Video Frame Interpolation, based on rife-ncnn-vulkan"
HOMEPAGE="https://github.com/styler00dollar/VapourSynth-RIFE-ncnn-Vulkan"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/styler00dollar/VapourSynth-RIFE-ncnn-Vulkan.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/styler00dollar/VapourSynth-RIFE-ncnn-Vulkan/archive/r${MY_PV}_mod_v${PATCH}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="mirror"
IUSE="lto"

RDEPEND+="
	|| (
		sys-devel/gcc[openmp]
		llvm-runtimes/clang-runtime[openmp]
	)
	dev-libs/ncnn
	dev-util/glslang
	dev-util/vulkan-headers
	dev-util/vulkan-tools
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
	media-libs/vulkan-loader
	media-libs/zimg"
DEPEND="${RDEPEND}
"
BDEPEND="app-alternatives/ninja"

PATCHES="${FILESDIR}/ncnn-drop-use_shader_pack8.patch"

src_prepare() {
	default
	local install_path="$(vapoursynth get-plugin-dir)"

	sed -i "s|install_dir = vapoursynth_dep.get_variable(pkgconfig: 'libdir') / 'vapoursynth'|install_dir = '${install_path}'|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Duse_system_ncnn=true
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
