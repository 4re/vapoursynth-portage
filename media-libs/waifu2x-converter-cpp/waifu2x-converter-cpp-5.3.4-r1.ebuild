# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Super-Resolution for anime-style-art using opencv"
HOMEPAGE="https://github.com/DeadSix27/waifu2x-converter-cpp"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DeadSix27/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/DeadSix27/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT BSD BSD-2"
SLOT="0"
IUSE="cuda debug models opencl cpu_flags_x86_avx"

REQUIRED_USE="|| ( opencl cuda )"
RDEPEND+="
	>=media-libs/opencv-3.3.0
	opencl? ( virtual/opencl >=media-libs/opencv-3.3.0[opencl] )
	cuda? ( dev-util/nvidia-cuda-toolkit )
"
DEPEND="${RDEPEND}
"

PATCHES=( "${FILESDIR}/${PN}-fix-picojson.diff" )

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DINSTALL_MODELS="$(usex models)"
		-DX86OPT="$(usex cpu_flags_x86_avx)"
		-DENABLE_CUDA="$(usex cuda)"
		-DENABLE_OPENCV="$(usex opencl)"
	)

	if use debug; then
		mycmakeargs+=(
			-DCMAKE_BUILD_TYPE="Debug"
		)
	else
		mycmakeargs+=(
			-DCMAKE_BUILD_TYPE="Release"
		)
	fi

	cmake_src_configure
}

pkg_postinst() {
	elog "Be aware that to use this package as a standalone app you"
	elog "need to set the use flag \"models\"."
}
