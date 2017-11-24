# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs git-r3

DESCRIPTION="Spatial dotcrawl remover for VapourSynth"
HOMEPAGE="https://github.com/myrsloik/DotKill"

EGIT_REPO_URI="https://github.com/myrsloik/DotKill.git"
EGIT_COMMIT="40a737be3d940fa008fbcf840fe9d60836a15a7f"

KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libdotkill.so"
COMMON_FLAGS="-shared -fPIC"

src_compile() {
	$(tc-getCC) ${COMMON_FLAGS} ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) dotkill1.cpp || die "Build failed"
}

src_install() {
	insinto "/usr/$(get_libdir)/vapoursynth/"
	doins ${LIBNAME}
}
