# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="An optimized pixelwise OpenCL implementation of the Non-local means denoising algorithm"
HOMEPAGE="https://github.com/Khanattila/KNLMeansCL"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Khanattila/KNLMeansCL.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Khanattila/KNLMeansCL/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="LGPL-3"
SLOT="0/1.1"
CARDS=( nvidia )
IUSE="${CARDS[@]/#/video_cards_}"

RDEPEND+="
	media-libs/vapoursynth
	virtual/opencl
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
"
DEPEND="${RDEPEND}
"
