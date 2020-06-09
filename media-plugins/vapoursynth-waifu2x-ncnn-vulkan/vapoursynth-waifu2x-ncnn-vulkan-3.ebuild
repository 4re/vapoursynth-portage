# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Waifu2x filter for VapourSynth, based on waifu2x-ncnn-vulkan"
HOMEPAGE="https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan.git"
	SRC_URI="https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan/releases/download/r0.1/models.7z"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz
			https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan/releases/download/r0.1/models.7z"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="mirror"

RDEPEND+="
	dev-libs/ncnn[vulkan]
	dev-util/glslang
	dev-util/vulkan-headers
	dev-util/vulkan-tools
	media-libs/vulkan-loader"
DEPEND="${RDEPEND}
"

PATCHES=( "${FILESDIR}/${PN}-3-fix-build.diff" )

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		git-r3_src_fetch
		git-r3_checkout
		default
	else
		default
		S="${WORKDIR}/${PN}-r${PV}"
	fi
}

src_install() {
	insinto /usr/$(get_libdir)/vapoursynth/
	doins "${BUILD_DIR}/libvsw2xnvk.so"
	doins -r "${WORKDIR}/models-cunet"
	doins -r "${WORKDIR}/models-upconv_7_anime_style_art_rgb"
	doins -r "${WORKDIR}/models-upconv_7_photo"
	dodoc "README.md"
}
