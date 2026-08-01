# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=no

DESCRIPTION="VapourSynth OpenCL Zig Image Process"
HOMEPAGE="https://github.com/dnjulek/vapoursynth-zipcl"

declare -g -r -A ZBS_DEPENDENCIES=(
	[opencl-0.1.0-W4Df3T2pNADIuy4qaFJPneWCDecwqOZJRmM1Zflxj16I.tar.gz]='https://github.com/Snektron/opencl-zig/archive/daa3a65b0e342b30460d136982503de975401841.tar.gz'
	[vapoursynth-4.0.0-jLYMQ6DjAgDFOODh8tdhWCw0iGHMPKiR4znTJwSyvV36.tar.gz]='https://github.com/dnjulek/vapoursynth-zig/archive/b87ff61ce680fa5a4cf7d44a9cb4b605c5037432.tar.gz'
	[N-V-__8AAN3BBwCtNSEaUAtAIADD-1Db9XVKTNQVOc3eSwAZ.tar.gz]='https://github.com/KhronosGroup/OpenCL-Headers/archive/v2024.05.08.tar.gz'
)

ZIG_SLOT="0.16"

inherit distutils-r1 zig

SRC_URI="
	https://github.com/dnjulek/vapoursynth-zipcl/archive/${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
CARDS=( nvidia )
IUSE="${CARDS[@]/#/video_cards_}"

RDEPEND="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
	virtual/opencl
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers
		dev-libs/opencl-icd-loader
		)
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

src_install() {
	zig_src_install --prefix-lib-dir "$(vapoursynth get-plugin-dir)"
}
