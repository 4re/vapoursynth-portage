# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="A ported AA-script from Avisynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/vsTAAmbk"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/vsTAAmbk.git"
# EGIT_COMMIT=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE="opencl"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP},vapoursynth_plugins_removegrain,vapoursynth_plugins_miscfilters]
	media-plugins/vapoursynth-awarpsharp2
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-havsfunc
	media-plugins/vapoursynth-mvsfunc
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-sangnom
	opencl? ( media-plugins/vapoursynth-tcanny[opencl] )
	!opencl? ( media-plugins/vapoursynth-tcanny )
"
DEPEND="${RDEPEND}"


src_install(){
	python_domodule vsTAAmbk.py
}
