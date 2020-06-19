# Copyright 1999-2020 Gentoo Authors
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
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0[threads]
	>=sys-devel/gcc-7.2.0
"
DEPEND="${RDEPEND}
"

DOCS=( "doc/fft3dfilter.md" )

src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
