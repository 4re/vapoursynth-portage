# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1 git-r3

DESCRIPTION="kageru's Vapoursynth functions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/kagefunc"

EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/kagefunc.git"
EGIT_COMMIT="ab4f79a4d04a70bc83ef3e37d68c01fb4995a902"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP},vapoursynth_plugins_miscfilters]
	media-plugins/vapoursynth-addgrain
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-descale
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-fvsfunc
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-mvsfunc
	media-plugins/vapoursynth-retinex
	media-plugins/vapoursynth-tcanny
	media-plugins/vapoursynth-wwxd
	media-plugins/vsutil
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule kagefunc.py
}
