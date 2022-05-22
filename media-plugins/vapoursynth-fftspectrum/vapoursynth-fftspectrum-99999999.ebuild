# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A VapourSynth filter that displays the FFT frequency spectrum of a given clip"
HOMEPAGE="https://github.com/Beatrice-Raws/FFTSpectrum"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Beatrice-Raws/FFTSpectrum.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Beatrice-Raws/FFTSpectrum/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="cpu_flags_x86_sse4_2"
REQUIRED_USE="cpu_flags_x86_sse4_2"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0
"
DEPEND="${RDEPEND}
"
