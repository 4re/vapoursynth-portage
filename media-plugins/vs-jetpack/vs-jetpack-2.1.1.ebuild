# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling

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
RESTRICT="mirror"
IUSE="opencl"

BDEPEND="
	$(python_gen_cond_dep 'dev-python/versioningit[${PYTHON_USEDEP}]')
"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/bestsource
	media-plugins/vapoursynth-d2vsource
	media-plugins/vapoursynth-ffmpegsource
	media-plugins/adaptivegrain
	media-plugins/dmetrics
	media-plugins/hysteresis
	media-plugins/manipulate-motion-vectors
	media-plugins/subtext
	media-plugins/vapoursynth-akarin
	media-plugins/vapoursynth-awarp
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-bwdif
	media-plugins/vapoursynth-deblock
	media-plugins/vapoursynth-descale
	media-plugins/vapoursynth-eedi3
	media-plugins/vapoursynth-edgemasks
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-resize2
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-sneedif
	media-plugins/vapoursynth-zip
	media-plugins/vapoursynth-znedi3
	media-plugins/vapoursynth-zsmooth
	media-plugins/vivtc
	media-plugins/vs-dfttest2
	media-plugins/vs-nlm-ispc
	media-plugins/vs-noise
	media-plugins/vs-placebo
	opencl? ( media-plugins/vapoursynth-knlmeanscl )
	$(python_gen_cond_dep '>=dev-python/jetpytools-3.1.0[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/psutil[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/rich[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/scipy[${PYTHON_USEDEP}]')
"
DEPEND="${RDEPEND}"
