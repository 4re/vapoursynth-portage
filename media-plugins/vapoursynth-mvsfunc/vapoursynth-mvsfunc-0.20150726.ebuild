# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_4 )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="mawen1250's VapourSynth functions"
HOMEPAGE="http://forum.doom9.org/showthread.php?p=1737309"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/mvsfunc.git"
EGIT_COMMIT="60007519ae1e83abdf029c13dc7cd2a608109eeb"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
	media-plugins/vapoursynth-addgrain
	media-plugins/vapoursynth-bilateral
	media-plugins/vapoursynth-ctmf
	media-plugins/vapoursynth-dctfilter
	media-plugins/vapoursynth-deblock
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-fft3dfilter
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-genericfilters
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-sangnommod
	media-plugins/vapoursynth-scenechange
	media-plugins/vapoursynth-temporalsoften
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}"

src_install(){
	insinto "$(python_get_sitedir)"
	doins mvsfunc.py
}
