# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Bilateral filter for VapourSynth based on the OpenCV-CUDA library"
HOMEPAGE="https://github.com/WolframRhodium/VapourSynth-BilateralGPU"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WolframRhodium/VapourSynth-BilateralGPU.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/WolframRhodium/VapourSynth-BilateralGPU/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

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
		-DCMAKE_CUDA_FLAGS="--threads 0 --use_fast_math -Wno-deprecated-gpu-targets"
	)
	cmake_src_configure
}
