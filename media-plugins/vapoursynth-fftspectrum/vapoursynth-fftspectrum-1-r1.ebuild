# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A VapourSynth filter that displays the FFT frequency spectrum of a given clip"
HOMEPAGE="https://github.com/Beatrice-Raws/FFTSpectrum"

inherit git-r3 meson

EGIT_REPO_URI="https://github.com/Beatrice-Raws/FFTSpectrum.git"
EGIT_COMMIT="26f8d31a058ddb9ff088128e89e886a625697692"

KEYWORDS="~amd64 ~x86"
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
