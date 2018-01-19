# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="VapourSynth port of FFT3DFilter"
HOMEPAGE="https://github.com/myrsloik/VapourSynth-FFT3DFilter"

EGIT_REPO_URI="https://github.com/myrsloik/VapourSynth-FFT3DFilter"
EGIT_COMMIT="9050e697f2c75d0e6cf3f44196fdd27aa66bbca2"

KEYWORDS="~x86 ~amd64"

LICENSE="GPL-2"
IUSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0[threads]
	>=sys-devel/gcc-7.2.0
"
DEPEND="${RDEPEND}
	dev-util/meson
	virtual/pkgconfig
"
