# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_4 )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="mawen1250's VapourSynth functions"
HOMEPAGE="http://forum.doom9.org/showthread.php?p=1737309"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/mvsfunc.git"
EGIT_COMMIT="f812e4779ecf8543bdc56c7dc911be10bd884cc9"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-zimg
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}"

src_install(){
	insinto "$(python_get_sitedir)"
	doins mvsfunc.py
}
