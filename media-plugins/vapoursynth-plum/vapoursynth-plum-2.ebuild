# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1 git-r3

DESCRIPTION="A sharpening/blind deconvolution suite with certain advanced features like Non-Local error, Block Matching, etc..."
HOMEPAGE="https://github.com/IFeelBloated/Plum"

EGIT_REPO_URI="https://github.com/IFeelBloated/Plum.git"
EGIT_COMMIT="cffeb87117f05d296b3b9451ee687a4fb439f9b4"

KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-vcfreq
	media-plugins/vapoursynth-mvtools-sf
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-nnedi3
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )

src_install(){
	use doc && dodoc ${DOCS}
	python_domodule Plum.py
}
