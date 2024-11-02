# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV=${PV%%_p*}
PATCH=${PV#*_p}

inherit meson

DESCRIPTION="Real-Time Intermediate Flow Estimation for Video Frame Interpolation, based on rife-ncnn-vulkan"
HOMEPAGE="https://github.com/styler00dollar/VapourSynth-RIFE-ncnn-Vulkan"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/styler00dollar/VapourSynth-RIFE-ncnn-Vulkan.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/styler00dollar/VapourSynth-RIFE-ncnn-Vulkan/archive/r${MY_PV}_mod_v${PATCH}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
	S=${WORKDIR}/${PF}
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+="
	|| (
		sys-devel/gcc[openmp]
		sys-devel/clang-runtime[openmp]
	)
	dev-libs/ncnn
	dev-util/glslang
	dev-util/vulkan-headers
	dev-util/vulkan-tools
	media-libs/vapoursynth
	media-libs/vulkan-loader
	media-libs/zimg"
DEPEND="${RDEPEND}
"
BDEPEND="app-alternatives/ninja"


src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Duse_system_ncnn=true
	)
	meson_src_configure
}
