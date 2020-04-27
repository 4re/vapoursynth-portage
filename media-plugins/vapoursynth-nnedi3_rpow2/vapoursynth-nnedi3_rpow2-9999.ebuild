# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1 git-r3

DESCRIPTION=""
HOMEPAGE=""

EGIT_REPO_URI="https://gist.github.com/4re/342624c9e1a144a696c6"
KEYWORDS=""

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-nnedi3
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule nnedi3_rpow2.py
}
