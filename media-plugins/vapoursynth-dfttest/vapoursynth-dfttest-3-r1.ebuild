# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib flag-o-matic

DESCRIPTION="2D/3D frequency domain denoiser"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DFTTest"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0[threads]
"
DEPEND="${RDEPEND}
"

src_prepare() {
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCC)\":" \
		-e "s:LD=\"g++\":LD=\"$(tc-getCC)\":" configure || die
}

src_configure() {
	# We need -mno-avx / -mno-xop here to fix compilation on AMD
	if [[ $(uname -a) =~ .*AuthenticAMD.* ]]; then
		if [[ $(tc-getCXX) != "clang++" ]]; then
			if [[ $(gcc-major-version) != "5" ]]; then
				ewarn "AMD cpu detected, dissabling avx optimizations due to a bug in the code."
				append-cxxflags -mno-avx
			else
				ewarn "AMD cpu detected, dissabling xop optimizations due to a bug in the code."
				append-cxxflags -mno-xop
			fi
		fi
	fi

	./configure \
		--install="${ED}/usr/$(get_libdir)/vapoursynth/" \
		--extra-cxxflags="${CXXFLAGS}" --extra-ldflags="${LDFLAGS}" || die "configure failed"
}

src_install() {
	emake install
	dodoc README.md
}
