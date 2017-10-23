# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-utils-r1 python-single-r1

DESCRIPTION="HolyWu's ported AviSynth scripts for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166582"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/havsfunc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/havsfunc/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE="+fftw opencl"

RDEPEND+="
	>=media-libs/vapoursynth-39[${PYTHON_USEDEP},vapoursynth_plugins_miscfilters]
	media-plugins/vapoursynth-addgrain
	media-plugins/vapoursynth-adjust
	media-plugins/vapoursynth-awarpsharp2
	media-plugins/vapoursynth-bilateral
	media-plugins/vapoursynth-ctmf
	media-plugins/vapoursynth-dctfilter
	media-plugins/vapoursynth-deblock
	fftw? ( media-plugins/vapoursynth-depan )
	fftw? ( media-plugins/vapoursynth-dfttest )
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-eedi3
	media-plugins/vapoursynth-flash3kyuu_deband
	media-plugins/vapoursynth-fluxsmooth
	fftw? ( media-plugins/vapoursynth-fft3dfilter )
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-hqdn3d
	opencl? ( >=media-plugins/vapoursynth-knlmeanscl-1.0.2 )
	media-plugins/vapoursynth-mvsfunc
	fftw? ( media-plugins/vapoursynth-mvtools )
	media-plugins/vapoursynth-nnedi3
	opencl? ( media-plugins/vapoursynth-nnedi3cl )
	media-plugins/vapoursynth-nnedi3_resample
	media-plugins/vapoursynth-sangnom
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule havsfunc.py
}
