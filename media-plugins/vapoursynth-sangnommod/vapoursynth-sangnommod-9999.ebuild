# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 eutils

DESCRIPTION="A deinterlace / antialiasing plugin for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-SangNomMod"
EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-SangNomMod.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

#src_prepare() {
#	chmod +x configure
#}

#src_configure() {
#	./configure --install="/usr/lib/vapoursynth/" --gcc --extra-cxxflags=${CFLAGS} --extra-ldflags=${LDFLAGS} --sse
#}

src_configure() {
	echo "No configure."
}

src_compile() {
#	$(tc-getCC) -shared -fPIC -std=c++11 ${CFLAGS} ${LDFLAGS} -o libyadifmod.so $(pkg-config --cflags vapoursynth) Yadifmod/Yadifmod.cpp || die "Build failed"
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -Wall -shared -fPIC -std=c++11 -o libsangnommod.so -I./src $(pkg-config --cflags vapoursynth) -lvapoursynth src/*.cpp || die "Build failed"
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	doexe libsangnommod.so
	dodoc README.md LICENSE
}
