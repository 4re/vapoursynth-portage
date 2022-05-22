# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1

DESCRIPTION="A derainbow function for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-dfmderainbow"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-dfmderainbow.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/vapoursynth-dfmderainbow/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE="+fftw"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-temporalmedian
	media-plugins/vapoursynth-temporalsoften2
	media-plugins/vapoursynth-fluxsmooth
	media-plugins/vapoursynth-msmoosh
	media-plugins/vapoursynth-minideen
	fftw? (
		media-plugins/vapoursynth-mvtools
		media-plugins/vapoursynth-fft3dfilter
	)
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule dfmderainbow.py
}
