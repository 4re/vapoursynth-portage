# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="VapourSynth port of FFT3DFilter"
HOMEPAGE="https://github.com/myrsloik/VapourSynth-FFT3DFilter"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/VapourSynth-FFT3DFilter"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/myrsloik/VapourSynth-FFT3DFilter/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

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
