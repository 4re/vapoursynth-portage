# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Spatial dotcrawl remover for VapourSynth"
HOMEPAGE="https://github.com/myrsloik/DotKill"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/DotKill.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/myrsloik/DotKill/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
