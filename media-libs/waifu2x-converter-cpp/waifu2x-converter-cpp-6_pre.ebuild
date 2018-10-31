# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Image Super-Resolution for anime-style-art using Deep Convolutional Neural Networks implementation in c++ using opencv"
HOMEPAGE="https://github.com/DeadSix27/waifu2x-converter-cpp"

EGIT_REPO_URI="https://github.com/DeadSix27/${PN}.git"
EGIT_COMMIT="0529f441b7e13831ebcef3e90b1a96c58272a31e"

KEYWORDS="~x86 ~amd64"

LICENSE="MIT BSD BSD-2"
SLOT="0"
IUSE="cuda doc debug models opencl cpu_flags_x86_avx"

RDEPEND+="
	>=media-libs/opencv-3.3.0
	virtual/opencl
	opencl? ( >=media-libs/opencv-3.3.0[opencl] )
	cuda? ( dev-util/nvidia-cuda-toolkit )
"
DEPEND="${RDEPEND}
"


src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DINSTALL_DOCS="$(usex doc)"
		-DINSTALL_MODELS="$(usex models)"
		-DX86OPT="$(usex cpu_flags_x86_avx)"
	)

	if ! use cuda; then
		mycmakeargs+=(
			-DCUDA_TOOLKIT_ROOT_DIR=""
		)
	fi

	if use debug; then
		mycmakeargs+=(
			-DCMAKE_BUILD_TYPE="Debug"
		)
	else
		mycmakeargs+=(
			-DCMAKE_BUILD_TYPE="Release"
		)
	fi

	cmake-utils_src_configure
}

pkg_postinst() {
	elog "Be aware that to use this package as a standalone app you"
	elog "need to set the use flag \"models\"."
}
