# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1 git-r3

DESCRIPTION="A collection of a non-local error based de-halo filter and a set of morphological filters"
HOMEPAGE="https://github.com/IFeelBloated/Vine"

EGIT_REPO_URI="https://github.com/IFeelBloated/Vine.git"
EGIT_COMMIT="b8285e8d17f020bdae8ab722dbf33a0e91763dca"

KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-tcanny
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-nnedi3
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )

src_install(){
	use doc && dodoc ${DOCS}
	python_domodule Vine.py
}
