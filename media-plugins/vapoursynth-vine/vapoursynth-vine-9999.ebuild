# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-utils-r1 python-single-r1

DESCRIPTION="A collection of a non-local error based de-halo filter and a set of morphological filters"
HOMEPAGE="https://github.com/IFeelBloated/Vine"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/Vine.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/IFeelBloated/Vine/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
	python_domodule Vine.py
}
