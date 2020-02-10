# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="An optimized pixelwise OpenCL implementation of the Non-local means denoising algorithm"
HOMEPAGE="https://github.com/Khanattila/KNLMeansCL"

EGIT_REPO_URI="https://github.com/Khanattila/KNLMeansCL.git"
EGIT_COMMIT="36bb2b1bb648a8f3552c4b2b841d10b4d65ec12b"
KEYWORDS="~x86 ~amd64"

LICENSE="LGPL-3"
SLOT="0/1.1"
CARDS=( nvidia )
IUSE="${CARDS[@]/#/video_cards_}"

RDEPEND+="
	media-libs/vapoursynth
	virtual/opencl
	video_cards_nvidia? ( 
		x11-drivers/nvidia-drivers[uvm]
		dev-libs/ocl-icd
		)
"
DEPEND="${RDEPEND}
"
