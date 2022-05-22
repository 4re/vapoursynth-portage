# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs git-r3

DESCRIPTION="VapourSynth plugin for image inpaintin"
HOMEPAGE="https://github.com/invisiblearts/VapourSynth-Inpaint"
EGIT_REPO_URI="https://github.com/invisiblearts/${PN}.git"
EGIT_COMMIT="dafa5b52a0dd05a17901950add8677ededcb50a2"

LICENSE=""
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

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
	if has_version ">=media-libs/opencv-4.0.0"; then
		opencv_inc="$(pkg-config --cflags opencv4)"
		opencv_lib="$(pkg-config --libs opencv4)"
	else
		opencv_inc="$(pkg-config --cflags opencv)"
		opencv_lib="$(pkg-config --libs opencv)"
	fi
}

src_compile() {
	echo "$(tc-getCC) ${selfcflags} ${CFLAGS} ${opencv_inc} $(pkg-config --cflags vapoursynth) -c Inpaint.cpp -o Inpaint.o"
	$(tc-getCC) ${selfcflags} ${CFLAGS} ${opencv_inc} $(pkg-config --cflags vapoursynth) -c Inpaint.cpp -o Inpaint.o || die

	echo "$(tc-getCC) ${CFLAGS} ${selfldflags} ${LDFLAGS} Inpaint.o ${opencv_lib} -o ${libname}"
	$(tc-getCC) ${CFLAGS} ${selfldflags} ${LDFLAGS} Inpaint.o ${opencv_lib} -o ${libname} || die
}

src_install() {
	exeinto "/usr/$(get_libdir)/vapoursynth/"
	doexe ${libname}
	dodoc README.md
}
