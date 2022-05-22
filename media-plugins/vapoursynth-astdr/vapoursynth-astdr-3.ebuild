# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1

DESCRIPTION="A derainbow function for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-astdr"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-astdr.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-astdr/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-miscfilters-obsolete
	media-plugins/vs-removegrain
	media-plugins/vapoursynth-adjust
	media-plugins/vapoursynth-awarpsharp2
	media-plugins/vapoursynth-ctmf
	media-plugins/vapoursynth-decross
	media-plugins/vapoursynth-fft3dfilter
	media-plugins/vapoursynth-fluxsmooth
	media-plugins/vapoursynth-hqdn3d
	media-plugins/vapoursynth-motionmask
	media-plugins/vapoursynth-mvtools
	media-plugins/vapoursynth-temporalsoften2
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule ASTDR.py
}
