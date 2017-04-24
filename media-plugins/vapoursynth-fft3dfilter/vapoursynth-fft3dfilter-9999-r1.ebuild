# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="VapourSynth port of FFT3DFilter"
HOMEPAGE="https://github.com/VFR-maniac/VapourSynth-FFT3DFilter"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/VFR-maniac/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/VFR-maniac/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-2"
IUSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0[threads]
"
DEPEND="${RDEPEND}
"

PATCHES=("${FILESDIR}/${P}-cmath.patch")

src_prepare() {
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCC)\":" configure || die

	eapply ${PATCHES}
	eapply_user
}

src_configure() {
	./configure --prefix="${ROOT}/usr" --extra-cxxflags="${CXXFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}
