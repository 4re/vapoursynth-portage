# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Spatial dotcrawl remover for VapourSynth"
HOMEPAGE="https://github.com/myrsloik/DotKill"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/DotKill.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/myrsloik/DotKill/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
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
COMMON_FLAGS="-shared -fPIC -std=c++17"

src_compile() {
	$(tc-getCC) ${COMMON_FLAGS} ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) dotkill1.cpp || die "Build failed"
}

src_install() {
	insinto "/usr/$(get_libdir)/vapoursynth/"
	doins ${LIBNAME}
}
