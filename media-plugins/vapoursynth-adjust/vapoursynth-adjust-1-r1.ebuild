# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1 git-r3

DESCRIPTION="This is a very basic port of the built-in Avisynth filter Tweak"
HOMEPAGE="https://github.com/dubhater/vapoursynth-adjust"

EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-adjust.git"
EGIT_COMMIT="a3af7cb57cb37747b0667346375536e65b1fed17"
KEYWORDS="~amd64 ~x86"

LICENSE="WTFPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_install(){
	python_domodule adjust.py
	dodoc readme.rst
}
