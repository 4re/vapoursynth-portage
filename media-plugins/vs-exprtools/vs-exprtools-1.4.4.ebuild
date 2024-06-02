# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="VapourSynth functions and helpers for writing RPN expressions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vs-exprtools"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vs-exprtools.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vs-exprtools/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vs-tools[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-akarin
	$(python_gen_cond_dep 'dev-python/rich[${PYTHON_USEDEP}]')
"
DEPEND="${RDEPEND}"
