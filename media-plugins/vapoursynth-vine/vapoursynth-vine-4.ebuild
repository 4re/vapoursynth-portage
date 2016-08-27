# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="A collection of a non-local error based de-halo filter and a set of morphological filters"
HOMEPAGE="https://github.com/IFeelBloated/Vine"

EGIT_REPO_URI="https://github.com/IFeelBloated/Vine.git"
EGIT_COMMIT="9889cf0ec5d1c45df179efaa86f4de76e3f067a1"

KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
	media-plugins/vapoursynth-tcanny
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-nnedi3
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )

src_install(){
	use doc && dodoc ${DOCS}
	insinto "$(python_get_sitedir)"
	doins Vine.py
}
