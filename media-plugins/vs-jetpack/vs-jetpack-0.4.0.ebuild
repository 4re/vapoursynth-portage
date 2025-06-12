# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Suite of filters, wrappers, and helper funcs for VapourSynth"
HOMEPAGE="https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cuda"

RDEPEND+="
	!media-plugins/vs-aa
	!media-plugins/vs-dehalo
	!media-plugins/vs-denoise
	!media-plugins/vs-exprtools
	!media-plugins/vs-kernels
	!media-plugins/vs-masktools
	!media-plugins/vs-rgtools
	!media-plugins/vs-scale
	!media-plugins/vs-source
	!media-plugins/vs-tools
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-akarin
	media-plugins/vapoursynth-resize2
	media-plugins/vapoursynth-zip
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-eedi3
	media-plugins/vapoursynth-znedi3
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-neo_f3kdb
	media-plugins/vivtc
	media-plugins/vapoursynth-wnnm
	media-plugins/vapoursynth-bm3d
	cuda? ( media-plugins/vapoursynth-bm3dcuda )
	media-plugins/vapoursynth-dctfilter
	media-plugins/vs-mlrt[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-mvtools
	|| (
		media-plugins/vapoursynth-scxvid
		media-plugins/vapoursynth-wwxd
	)
	media-plugins/vapoursynth-bwdif
	media-plugins/vapoursynth-fft3dfilter
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-descale
	media-plugins/vs-placebo
	media-plugins/vapoursynth-awarpsharp2
	media-plugins/vapoursynth-tcanny
	media-plugins/vapoursynth-tedgemask
	media-plugins/vapoursynth-bilateralgpu
	media-plugins/vapoursynth-dpid
	$(python_gen_cond_dep 'dev-python/jetpytools[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/rich[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/scipy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/typing-extensions[${PYTHON_USEDEP}]')
"
DEPEND="${RDEPEND}"
