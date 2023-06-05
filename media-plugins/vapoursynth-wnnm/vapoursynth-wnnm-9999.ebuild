# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Weighted Nuclear Norm Minimization Denoiser for VapourSynth"
HOMEPAGE="https://github.com/WolframRhodium/VapourSynth-WNNM"


if ver_test -ne 9999; then
	SRC_URI="https://github.com/WolframRhodium/VapourSynth-WNNM/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WolframRhodium/VapourSynth-WNNM.git"
	KEYWORDS=""
fi

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

if ver_test -ne 9999; then
	S="${WORKDIR}/VapourSynth-WNNM-${PV}"
fi

src_configure() {
	local mycmakeargs=(
		-DMKL_THREADING=sequential
		-DMKL_INTERFACE=lp64
	)
	cmake_src_configure
}
