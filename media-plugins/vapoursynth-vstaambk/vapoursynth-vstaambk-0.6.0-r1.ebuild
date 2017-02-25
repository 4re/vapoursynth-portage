# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="A ported AA-script from Avisynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/vsTAAmbk"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/vsTAAmbk.git"
EGIT_COMMIT="4082150ca5e251c55a47cb87158bb465db1412e2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP},vapoursynth_plugins_removegrain]
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-genericfilters
	media-plugins/vapoursynth-havsfunc
	media-plugins/vapoursynth-msmoosh
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-temporalsoften
"
DEPEND="${RDEPEND}"


src_prepare(){
	epatch "${FILESDIR}/${P}-sangnom.patch"
}

src_install(){
	python_domodule vsTAAmbk.py
}
