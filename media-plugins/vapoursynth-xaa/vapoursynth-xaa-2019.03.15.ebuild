# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="xaa is a many-in-one antialiasing function for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-xaa"

EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-xaa.git"
EGIT_COMMIT="a04c5f8b9a3b722b89a4a4aa9713f2d387639a2a"
KEYWORDS="~amd64 ~x86"

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP},vapoursynth_plugins_removegrain]
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-eedi3
	media-plugins/vapoursynth-znedi3
	media-plugins/vapoursynth-nnedi3cl
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-tcanny
	media-plugins/vapoursynth-tedgemask
"
DEPEND="${RDEPEND}"

DOCS=( "readme.rst" )


src_install(){
	python_domodule xaa.py
}
