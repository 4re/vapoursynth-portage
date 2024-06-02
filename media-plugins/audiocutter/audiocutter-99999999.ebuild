# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1

DESCRIPTION="A tool to cut audio and generate associated chapters/qpfiles for vapoursynth"
HOMEPAGE="https://github.com/AzraelNewtype/audiocutter"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AzraelNewtype/audiocutter.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/AzraelNewtype/audiocutter/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-video/mkvtoolnix
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )


src_install(){
	python_domodule audiocutter.py
}
