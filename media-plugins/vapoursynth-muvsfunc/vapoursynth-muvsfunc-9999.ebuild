# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="Muonium's VapourSynth functions"
HOMEPAGE="https://github.com/WolframRhodium/muvsfunc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WolframRhodium/muvsfunc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/WolframRhodium/muvsfunc/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

IUSE="deprecated examples misc numpy"
LICENSE=""
SLOT="0"

RDEPEND+="
	numpy? ( $(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]') )
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/subtext
	media-plugins/vapoursynth-havsfunc[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-miscfilters-obsolete
	deprecated? ( media-plugins/vapoursynth-knlmeanscl )
	media-plugins/vapoursynth-awarpsharp2
	media-plugins/vapoursynth-bilateral
	media-plugins/vapoursynth-ctmf
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-histogram
	media-plugins/vapoursynth-median
	media-plugins/vapoursynth-mvsfunc[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-tcanny
	misc? ( media-plugins/vapoursynth-vcfreq )
	media-plugins/vivtc
	media-plugins/vs-removegrain
"
DEPEND="${RDEPEND}"


src_install(){
	python_domodule muvsfunc.py

	if use misc; then
		python_domodule Collections/{muvsfunc_misc,net_interp,resize}.py
	fi
	if use numpy; then
		python_domodule Collections/muvsfunc_numpy.py
	fi
	if use deprecated; then
		python_domodule Collections/{LUM,SuperRes}.py
	fi
	if use examples; then
		DOCS="Collections/examples/"; einstalldocs
	fi
}
