# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="A function to use invks/debilinear"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=171546"
EGIT_REPO_URI="https://github.com/MonoS/VS-MaskDetail.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_install(){
	python_domodule MaskDetail.py
}
