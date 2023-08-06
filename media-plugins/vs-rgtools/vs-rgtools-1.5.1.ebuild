# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Functions and utils related to VapourSynth"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vs-rgtools"

if ver_test -eq 9999; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vs-rgtools.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vs-rgtools/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-exprtools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-pyplugin[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-tools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-removegrain
	media-plugins/vapoursynth-rgsf
	media-plugins/vapoursynth-akarin
"
DEPEND="${RDEPEND}"
