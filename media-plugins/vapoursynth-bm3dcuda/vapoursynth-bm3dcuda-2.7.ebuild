# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="BM3D denoising filter for VapourSynth, implemented in CUDA"
HOMEPAGE="https://github.com/WolframRhodium/VapourSynth-BM3DCUDA"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WolframRhodium/VapourSynth-BM3DCUDA.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/WolframRhodium/VapourSynth-BM3DCUDA/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="cpu +cuda cpu_flags_x86_avx cpu_flags_x86_avx2"
REQUIRED_USE="cpu_flags_x86_avx
	cpu? ( cpu_flags_x86_avx2 )
"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth
	dev-util/nvidia-cuda-toolkit
"
DEPEND="${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="$(get_libdir)/vapoursynth/"
		-DVAPOURSYNTH_INCLUDE_DIRECTORY="$(pkg-config --cflags-only-I vapoursynth | sed 's/-I//')"
		-DUSE_NVRTC_STATIC=NO
		-DENABLE_CPU=$(usex cpu ON OFF)
		-DENABLE_CUDA=$(usex cuda ON OFF)
	)
	cmake_src_configure
}
