# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_4 )

inherit python-utils-r1 python-single-r1

DESCRIPTION="HolyWu's ported AviSynth scripts for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166582"
SRC_URI="https://dl.dropboxusercontent.com/u/36232595/havsfunc-r${PV}.7z"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
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
	app-arch/p7zip
"

S="${WORKDIR}"

src_install(){
	insinto "$(python_get_sitedir)"
	doins havsfunc.py
}
