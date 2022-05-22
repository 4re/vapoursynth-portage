# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1

DESCRIPTION="This is a very basic port of the built-in Avisynth filter Tweak"
HOMEPAGE="https://github.com/dubhater/vapoursynth-adjust"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-adjust.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-adjust/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
