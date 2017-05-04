# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs git-r3

DESCRIPTION="VapourSynth plugin for image inpaintin"
HOMEPAGE="https://github.com/invisiblearts/VapourSynth-Inpaint"
EGIT_REPO_URI="https://github.com/invisiblearts/${PN}.git"
EGIT_COMMIT="dafa5b52a0dd05a17901950add8677ededcb50a2"

LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	media-libs/opencv
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${PN}-fix-include.patch"
}

src_configure() {
	# No build system upstream
	selfcflags="-Wall -fPIC -std=c++11"
	selfldflags="-shared"
	libname="libinpaint.so"
}

src_compile() {
	echo "$(tc-getCC) ${selfcflags} ${CFLAGS} $(pkg-config --cflags vapoursynth) -c Inpaint.cpp -o Inpaint.o"
	$(tc-getCC) ${selfcflags} ${CFLAGS} $(pkg-config --cflags vapoursynth) -c Inpaint.cpp -o Inpaint.o || die

	echo "$(tc-getCC) ${CFLAGS} ${selfldflags} ${LDFLAGS} Inpaint.o $(pkg-config --libs opencv) -o ${libname}"
	$(tc-getCC) ${CFLAGS} ${selfldflags} ${LDFLAGS} Inpaint.o $(pkg-config --libs opencv) -o ${libname} || die
}

src_install() {
	exeinto "/usr/$(get_libdir)/vapoursynth/"
	doexe ${libname}
	dodoc README.md
}
