# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5} )

inherit python-utils-r1 python-single-r1

DESCRIPTION="HolyWu's ported AviSynth scripts for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166582"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/havsfunc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/havsfunc/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
	media-plugins/vapoursynth-addgrain
	media-plugins/vapoursynth-adjust
	media-plugins/vapoursynth-awarpsharp2
	media-plugins/vapoursynth-bilateral
	media-plugins/vapoursynth-ctmf
	media-plugins/vapoursynth-dctfilter
	media-plugins/vapoursynth-deblock
	media-plugins/vapoursynth-depan
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-fft3dfilter
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-genericfilters
	media-plugins/vapoursynth-mvsfunc
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-sangnommod
	media-plugins/vapoursynth-scenechange
	media-plugins/vapoursynth-temporalsoften
"
DEPEND="${RDEPEND}"

src_install(){
	insinto "$(python_get_sitedir)"
	doins havsfunc.py
}
