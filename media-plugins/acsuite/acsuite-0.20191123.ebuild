# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1 git-r3

DESCRIPTION="Frame-based cutting/trimming/splicing of audio files from within VapourSynth"
HOMEPAGE="https://github.com/OrangeChannel/acsuite"

EGIT_REPO_URI="https://github.com/OrangeChannel/acsuite.git"
EGIT_COMMIT="55c9c174d6dd67345514389ccb3af9be906ba8bf"
KEYWORDS="~amd64 ~x86"

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
	python_domodule acsuite.py
}
