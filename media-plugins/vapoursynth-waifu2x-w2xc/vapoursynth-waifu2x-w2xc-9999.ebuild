# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="Image super-resolution/denoise filter for VapourSynth, based on the waifu2x-opt library"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Waifu2x-w2xc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="debug"

RDEPEND+="
	media-libs/vapoursynth
	media-libs/waifu2x-converter-cpp
"
DEPEND="${RDEPEND}
"

src_configure() {
	./autogen.sh
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCXX)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCXX)\":" configure || die

	if use debug; then
		myflags="--enable-debug"
	fi

	./configure \
		--prefix="${ED}/usr/$(get_libdir)/vapoursynth/" \
		CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" \
		${myflags} || die "configure failed"
}

src_install() {
	emake install
	cp -R "${S}/Waifu2x-w2xc/models/" "${D}/usr/$(get_libdir)/vapoursynth" || die
}
