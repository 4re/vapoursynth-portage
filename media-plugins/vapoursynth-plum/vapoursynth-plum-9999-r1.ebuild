# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="A sharpening/blind deconvolution suite with certain advanced features like Non-Local error, Block Matching, etc..."
HOMEPAGE="https://github.com/IFeelBloated/Plum"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/Plum.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/IFeelBloated/Plum/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-dfttest
	media-plugins/vapoursynth-vcm
	media-plugins/vapoursynth-mvtools-sf
	media-plugins/vapoursynth-knlmeanscl
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-nnedi3
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )

PATCHES=( "${FILESDIR}/fix-vcm-dep-change.patch" )


src_install(){
	use doc && dodoc ${DOCS}
	python_domodule Plum.py
	python_domodule PlumAlpha.py
}
