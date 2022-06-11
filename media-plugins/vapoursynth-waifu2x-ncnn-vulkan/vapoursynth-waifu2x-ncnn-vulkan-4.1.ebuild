# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Waifu2x filter for VapourSynth, based on waifu2x-ncnn-vulkan"
HOMEPAGE="https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan.git"
	SRC_URI="https://www.dropbox.com/s/cimgo7ec17jrnq2/vapoursynth-waifu2x-ncnn-vulkan-models-0.1.tar.bz2"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Nlzy/vapoursynth-waifu2x-ncnn-vulkan/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz
			https://www.dropbox.com/s/cimgo7ec17jrnq2/vapoursynth-waifu2x-ncnn-vulkan-models-0.1.tar.bz2"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="mirror"

RDEPEND+="
	dev-libs/ncnn
	dev-util/glslang
	dev-util/vulkan-headers
	dev-util/vulkan-tools
	media-libs/vulkan-loader"
DEPEND="${RDEPEND}
"

PATCHES=( "${FILESDIR}/${PN}-4.1-fix-build.diff" )

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
