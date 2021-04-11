# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1 git-r3

DESCRIPTION="A function to use invks/debilinear"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=171546"
EGIT_REPO_URI="https://github.com/MonoS/VS-MaskDetail.git"

LICENSE=""
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_install(){
	python_domodule MaskDetail.py
}
