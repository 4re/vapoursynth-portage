# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs git-r3

DESCRIPTION="Spatial dotcrawl remover for VapourSynth"
HOMEPAGE="https://github.com/myrsloik/DotKill"

EGIT_REPO_URI="https://github.com/myrsloik/DotKill.git"
EGIT_COMMIT="30660feabef28f9ebd8e11915e24d50f331bb58c"

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
