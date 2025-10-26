# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1 git-r3

DESCRIPTION="A derainbow function for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-dfmderainbow"

EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-dfmderainbow.git"
EGIT_COMMIT="61bafd9b3f4fa7839038c1a160382ab18fdb152b"
KEYWORDS="~amd64 ~x86"

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
