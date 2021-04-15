# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A high-performance neural network inference framework"
HOMEPAGE="https://github.com/Tencent/ncnn"

SRC_URI="https://github.com/Tencent/ncnn/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="
	dev-util/glslang
	dev-util/vulkan-headers
	media-libs/vulkan-loader"

RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT=test # Tests tries to use real GPU.

src_prepare() {
	sed -i -e 's~glslang/glslang/Public/ShaderLang.h~glslang/Public/ShaderLang.h~' "src/gpu.cpp" || die "sed died"
	eapply_user
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_TOOLCHAIN_FILE="${S}/toolchains/host.gcc.toolchain.cmake"
		-DGLSLANG_TARGET_DIR="/usr/$(get_libdir)/cmake/"
		-DNCNN_SYSTEM_GLSLANG=ON
		-DNCNN_BUILD_EXAMPLES=OFF
		-DNCNN_BUILD_TOOLS=OFF
		-DNCNN_VULKAN=ON
	)

	cmake_src_configure
}
