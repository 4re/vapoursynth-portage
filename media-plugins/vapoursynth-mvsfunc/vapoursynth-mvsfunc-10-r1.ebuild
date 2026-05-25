# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1

DESCRIPTION="mawen1250's VapourSynth functions"
HOMEPAGE="http://forum.doom9.org/showthread.php?p=1737309"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/mvsfunc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/mvsfunc/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-fmtconv
"
DEPEND="${RDEPEND}
"

src_install(){
	python_domodule mvsfunc.py
}
