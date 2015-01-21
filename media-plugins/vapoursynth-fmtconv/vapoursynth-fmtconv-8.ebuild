# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="A format-conversion plug-in for the Vapoursynth video processing engine"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166504"
SRC_URI="http://ldesoras.free.fr/src/vs/fmtconv-r${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="/var/tmp/portage/media-plugins/vapoursynth-fmtconv-${PV}/work/src"
LIBNAME="libfmtconv.so"

src_compile() {
    $(tc-getCC) \
        ${CFLAGS} ${LDFLAGS} \
        -shared -msse2 -fPIC \
        -o ${LIBNAME} AvstpWrapper.cpp main.cpp fmtc/*.cpp fstb/*.cpp vsutl/*.cpp -I. || die "compile failed"
}

src_install() {
    exeinto /usr/lib/vapoursynth/
    doexe ${LIBNAME} || die
    if use doc; then
        dohtml -r ../doc/* || die
    fi
}
