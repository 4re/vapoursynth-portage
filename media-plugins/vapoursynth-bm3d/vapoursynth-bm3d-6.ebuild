# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="BM3D denoising filter for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="-debug cpu_flags_x86_sse2 cpu_flags_x86_sse4_1"
REQUIRED_USE="|| ( cpu_flags_x86_sse2 cpu_flags_x86_sse4_1 )"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0
"
DEPEND="${RDEPEND}
"

src_configure() {
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCXX)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCXX)\":" configure || die

	if use debug; then
		myflags="--enable-debug"
	fi

	if use cpu_flags_x86_sse4_1; then
		myflags="${myflags} --target=sse4.1"
	elif use cpu_flags_x86_sse2; then
		myflags="${myflags} --target=sse2"
	fi

	./configure \
		--install="${ED}/usr/$(get_libdir)/vapoursynth/" \
		--extra-cxxflags="${CXXFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		${myflags} || die "configure failed"
}

src_install() {
	emake install
	dodoc README.md
}
