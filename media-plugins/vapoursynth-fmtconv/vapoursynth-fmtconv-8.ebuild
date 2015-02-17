# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="A format-conversion plug-in for the Vapoursynth video processing engine"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166504"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/fmtconv.git"
else
	inherit vcs-snapshot
	SRC_URI="http://ldesoras.free.fr/src/vs/fmtconv-r${PV}.zip -> ${PN}-${PV}.zip"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/src"
LIBNAME="libfmtconv.so"

src_compile() {
	$(tc-getCXX) \
		${CFLAGS} ${LDFLAGS} \
		-shared -msse2 -fPIC \
		-o ${LIBNAME} AvstpWrapper.cpp main.cpp fmtc/*.cpp fstb/*.cpp vsutl/*.cpp -I. || die "compile failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME} || die
	if use doc; then
		dohtml -r ../doc/* || die
	fi
}
