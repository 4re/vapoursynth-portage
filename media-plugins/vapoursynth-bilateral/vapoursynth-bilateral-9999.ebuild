# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="Bilateral filter for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Bilateral"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Bilateral.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

USFLAGS="-Wall -fpermissive -ffast-math -fexcess-precision=fast -shared -fPIC -std=c++11 -D__SSE -mssse3"


src_prepare() {
	sed -i 's/..\\include\\//g' source/*.cpp || die "Prepare failed"
	sed -i 's/vapoursynth\\//g' include/*.h source/*.cpp || die "Prepare failed"
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} ${USFLAGS} -o libbilateral.so -Iinclude $(pkg-config --cflags vapoursynth) -lvapoursynth source/*.cpp || die "Build failed"
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	doexe libbilateral.so
	dodoc README.md LICENSE
}
