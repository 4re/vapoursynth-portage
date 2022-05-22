# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1 git-r3

DESCRIPTION="nnedi3 rpow2 wrapper"
HOMEPAGE="https://gist.github.com/4re/342624c9e1a144a696c6"

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
