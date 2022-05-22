# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1 git-r3

DESCRIPTION="xaa is a many-in-one antialiasing function for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-xaa"

EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-xaa.git"
EGIT_COMMIT="58a9495dd1465b44bf8f89748fc23f6f4031c8e6"
KEYWORDS="~amd64 ~x86"

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-eedi3
	media-plugins/vapoursynth-znedi3
	media-plugins/vapoursynth-nnedi3cl
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-tcanny
	media-plugins/vapoursynth-tedgemask
	media-plugins/vs-removegrain
"
DEPEND="${RDEPEND}"

DOCS=( "readme.rst" )


src_install(){
	python_domodule xaa.py
}
