# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs git-r3

DESCRIPTION="VapourSynth port of ReduceFlicker"
HOMEPAGE="https://github.com/VFR-maniac/VapourSynth-ReduceFlicker
http://home.arcor.de/kassandro/ReduceFlicker/ReduceFlicker.htm"

EGIT_REPO_URI="https://github.com/VFR-maniac/${PN}.git"
EGIT_COMMIT="8766391ceeb2540d10a75550f09cdf6821392a69"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	chmod +x configure
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCC)\":" configure || die
}

src_configure() {
	./configure --prefix="${ROOT}/usr" \
				--libdir="${ROOT}/usr/$(get_libdir)" \
				--extra-cxxflags="${CXXFLAGS}" \
				--extra-ldflags="${LDFLAGS}" || die
}
