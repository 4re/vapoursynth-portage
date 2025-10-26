# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="Frechdachs's Vapoursynth functions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/fvsfunc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/fvsfunc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/fvsfunc/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cuda mpls dvd"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-removegrain
	media-plugins/vapoursynth-bilateral
	media-plugins/vapoursynth-descale
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-ffmpegsource
	media-plugins/vapoursynth-fft3dfilter
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-fft3dfilter
	media-plugins/vapoursynth-havsfunc
	media-plugins/vapoursynth-muvsfunc
	media-plugins/vapoursynth-mvsfunc
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-nnedi3_rpow2
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-yadifmod
	cuda? ( media-plugins/vapoursynth-bilateralgpu　)
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule fvsfunc.py
}
