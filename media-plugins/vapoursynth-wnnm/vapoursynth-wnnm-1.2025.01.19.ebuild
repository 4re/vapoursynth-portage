# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Weighted Nuclear Norm Minimization Denoiser for VapourSynth"
HOMEPAGE="https://github.com/WolframRhodium/VapourSynth-WNNM"

EGIT_REPO_URI="https://github.com/WolframRhodium/VapourSynth-WNNM.git"
EGIT_COMMIT="6d476bdb0ab7d988b5c5823678b4cae0cdbbbb85"

KEYWORDS="~x86 ~amd64"

LICENSE="MIT"
SLOT="0"
IUSE="cpu_flags_x86_avx2"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/mkl
	cpu_flags_x86_avx2? (
		sci-libs/vectorclass
	)
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DMKL_THREADING=sequential
		-DMKL_INTERFACE=lp64
	)
	cmake_src_configure
}
