# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Rapid, Detail-Preserving Image Downscaler for VapourSynth"
HOMEPAGE="https://github.com/WolframRhodium/VapourSynth-dpid"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WolframRhodium/VapourSynth-dpid.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/WolframRhodium/VapourSynth-dpid/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-3"
SLOT="0"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libdpid.so"
EXTRAFLAGS="-fPIC -shared --std=c++17"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) Source/Source.cpp || die "Build failed"
}

src_install() {
	insinto /usr/$(get_libdir)/vapoursynth/
	doins ${LIBNAME}
}
