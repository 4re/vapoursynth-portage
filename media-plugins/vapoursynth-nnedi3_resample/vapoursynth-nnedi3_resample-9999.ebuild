# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1

DESCRIPTION="A function for scaling, color space conversion, etc."
HOMEPAGE="https://github.com/mawen1250/VapourSynth-script"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mawen1250/VapourSynth-script.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/mawen1250/VapourSynth-script/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
