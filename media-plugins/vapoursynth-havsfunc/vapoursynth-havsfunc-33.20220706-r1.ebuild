# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1 git-r3

DESCRIPTION="HolyWu's ported AviSynth scripts for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166582"

EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/havsfunc.git"
EGIT_COMMIT="21b771350a7e1789a6bc6eb140e98f43a6263710"
KEYWORDS="~amd64 ~x86"

LICENSE=""
SLOT="0"
IUSE="+fftw opencl"


RDEPEND+="
	media-libs/vapoursynth:0/4
	media-plugins/vapoursynth-addgrain
	media-plugins/vapoursynth-adjust
	media-plugins/vapoursynth-awarpsharp2
	media-plugins/vapoursynth-bilateral
	media-plugins/vapoursynth-bwdif
	media-plugins/vapoursynth-cas
	media-plugins/vapoursynth-ctmf
	media-plugins/vapoursynth-dctfilter
	media-plugins/vapoursynth-deblock
	fftw? ( media-plugins/vapoursynth-dfttest )
	media-plugins/vapoursynth-eedi2
	fftw? ( media-plugins/vapoursynth-fft3dfilter )
	media-plugins/vapoursynth-flash3kyuu_deband
	media-plugins/vapoursynth-fluxsmooth
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-hqdn3d
	opencl? ( >=media-plugins/vapoursynth-knlmeanscl-1.0.2 )
	media-plugins/vapoursynth-miscfilters-obsolete
	media-plugins/vapoursynth-mvsfunc
	fftw? ( media-plugins/vapoursynth-mvtools )
	opencl? ( media-plugins/vapoursynth-nnedi3cl )
	media-plugins/vapoursynth-nnedi3_resample
	media-plugins/vapoursynth-sangnom
	media-plugins/vapoursynth-temporalsoften2
	media-plugins/vapoursynth-ttempsmooth
	media-plugins/vapoursynth-znedi3
	media-plugins/vsutil
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule havsfunc.py
}
