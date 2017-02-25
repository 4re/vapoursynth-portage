# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="Small and relatively fast realtime-sharpening function for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166524"
EGIT_REPO_URI="https://gist.github.com/8676fd350d4b5b223ab9.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

RDEPEND+="
	>=media-libs/vapoursynth-33[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}"

src_install(){
	python_domodule finesharp.py
}
