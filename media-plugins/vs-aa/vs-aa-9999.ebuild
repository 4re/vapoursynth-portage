# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="VapourSynth anti aliasing and scaling functions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vs-aa"

if ver_test -eq 9999; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vs-aa.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vs-aa/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="opencl"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-tools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-kernels[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-exprtools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-rgtools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-masktools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-eedi3
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-sangnom
	opencl? ( media-plugins/vapoursynth-nnedi3cl )
"
DEPEND="${RDEPEND}"
