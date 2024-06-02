# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="VapourSynth denoising, regression, and motion compensation functions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vs-denoise"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vs-denoise.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vs-denoise/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cuda"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-tools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-kernels[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-exprtools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-rgtools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-masktools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-aa[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-scale[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-mlrt[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-fft3dfilter
	cuda? ( media-plugins/vapoursynth-bm3dcuda )
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-bmdegrain
	media-plugins/vapoursynth-wnnm
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-nnedi3
"
DEPEND="${RDEPEND}"
