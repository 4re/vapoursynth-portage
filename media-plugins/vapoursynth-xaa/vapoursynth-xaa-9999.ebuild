# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1

DESCRIPTION="xaa is a many-in-one antialiasing function for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-xaa"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-xaa.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-xaa/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
