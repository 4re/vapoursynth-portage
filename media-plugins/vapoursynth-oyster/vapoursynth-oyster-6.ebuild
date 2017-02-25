# Copyright 1999-2017    Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="A top class de-noising filter against compression artifacts"
HOMEPAGE="https://github.com/IFeelBloated/Oyster"

EGIT_REPO_URI="https://github.com/IFeelBloated/Oyster.git"
EGIT_COMMIT="1daff941757c4a426b94b0edc210c1d178a0c01d"

KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-mvtools-sf
	media-plugins/vapoursynth-nnedi3
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )

src_install(){
	use doc && dodoc ${DOCS}
	python_domodule Oyster.py
}
