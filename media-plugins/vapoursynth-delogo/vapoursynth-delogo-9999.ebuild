# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="DeLogo Plugin Ported for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DeLogo"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DeLogo.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

USFLAGS="-Wall -fpermissive -ffast-math -fexcess-precision=fast -shared -fPIC -std=c++11 -D__SSE -mssse3"

src_configure() {
	echo "No configure."
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} ${USFLAGS} -o libdelogo.so -I. -I./src $(pkg-config --cflags vapoursynth) -lvapoursynth src/*.cpp || die "Build failed"
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe libdelogo.so
        dodoc README.md LICENSE
}
