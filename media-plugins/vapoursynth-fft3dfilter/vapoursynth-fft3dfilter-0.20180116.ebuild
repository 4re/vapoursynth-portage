# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs git-r3

DESCRIPTION="VapourSynth port of FFT3DFilter"
HOMEPAGE="https://github.com/myrsloik/VapourSynth-FFT3DFilter"

EGIT_REPO_URI="https://github.com/myrsloik/VapourSynth-FFT3DFilter"
EGIT_COMMIT="61a12e633ee94540e9809293dffac58f40b5c874"

KEYWORDS="~x86 ~amd64"

LICENSE="GPL-2"
IUSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0[threads]
"
DEPEND="${RDEPEND}
"

src_configure() {
	./configure --prefix="${ROOT}usr" \
				--libdir="${ROOT}usr/$(get_libdir)" \
				--extra-cxxflags="${CXXFLAGS} $(pkg-config --cflags vapoursynth)" \
				--extra-ldflags="${LDFLAGS}" || die
}
