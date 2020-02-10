# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="A function for scaling, color space conversion, etc."
HOMEPAGE="https://github.com/mawen1250/VapourSynth-script"

EGIT_REPO_URI="https://github.com/mawen1250/VapourSynth-script.git"
EGIT_COMMIT="0f4c0a7b0732be3f5f03f91f0c69ac447d19c0a8"

KEYWORDS="~amd64 ~x86"
LICENSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-mvsfunc
	media-plugins/vapoursynth-nnedi3
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule nnedi3_resample.py
}
