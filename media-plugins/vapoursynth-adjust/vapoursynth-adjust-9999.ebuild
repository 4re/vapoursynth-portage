# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="This is a very basic port of the built-in Avisynth filter Tweak"
HOMEPAGE="https://github.com/dubhater/vapoursynth-adjust"
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-adjust.git"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_install(){
	python_domodule adjust.py
	dodoc readme.rst
}
