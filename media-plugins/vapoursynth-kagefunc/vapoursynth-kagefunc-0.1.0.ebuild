# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="kageru's Vapoursynth functions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/kagefunc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/kagefunc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/kagefunc/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-addgrain
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-descale
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-fvsfunc
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-miscfilters-obsolete
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
