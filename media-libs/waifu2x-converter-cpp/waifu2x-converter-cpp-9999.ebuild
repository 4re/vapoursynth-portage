# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils

DESCRIPTION="Image Super-Resolution for anime-style-art using Deep Convolutional Neural Networks implementation in c++ using opencv"
HOMEPAGE="https://github.com/tanakamura/waifu2x-converter-cpp"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tanakamura/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/tanakamura/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT BSD BSD-2"
SLOT="0"
IUSE="cuda doc models debug cpu_flags_x86_avx"

RDEPEND+="
	>=media-libs/opencv-3.0.0
	cuda? ( dev-util/nvidia-cuda-toolkit )
"
DEPEND="${RDEPEND}
"

src_prepare() {
    epatch "${FILESDIR}/opencv-header.patch"
}

src_configure() {
	if use debug; then
		CMAKE_BUILD_TYPE=Debug
	else
		CMAKE_BUILD_TYPE=Release
	fi

	local mycmakeargs=(
		$(cmake-utils_use doc INSTALL_DOCS)
		$(cmake-utils_use models INSTALL_MODELS)
		$(cmake-utils_use cpu_flags_x86_avx X86OPT)
		$(cmake-utils_use_has cuda CUDA)
	)

	cmake-utils_src_configure
}
