# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1

DESCRIPTION="A function for scaling, color space conversion, etc."
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/nnedi3_resample"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/nnedi3_resample.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/nnedi3_resample/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
IUSE="opencl"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-mvsfunc
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-znedi3
	opencl? ( media-plugins/vapoursynth-nnedi3cl )
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule nnedi3_resample.py
}
