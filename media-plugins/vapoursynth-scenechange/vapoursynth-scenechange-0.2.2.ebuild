# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="3:3.3"
RESTRICT_PYTHON_ABIS="2.* 3.[0123]"

inherit python

DESCRIPTION="A scene change detection plugin for VapourSynth plus temporalsoften2 that makes use of it"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166769"
SRC_URI="https://dl.dropboxusercontent.com/u/36232595/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAMESC="libscenechange.so"
LIBNAMETS="libtemporalsoften2.so"

EXTRAFLAGS="-std=gnu99 -fPIC -ffast-math -fexcess-precision=fast -shared"


src_compile(){
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAMESC} $(pkg-config --cflags vapoursynth) src/scenechange.c || die "Build for scenechange failed"
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAMETS} $(pkg-config --cflags vapoursynth) src/temporalsoften.c || die "Build for temporalsoften2 failed"
}


src_install(){
	insinto "$(python_get_sitedir)"
	doins temporalsoften2.py
        exeinto /usr/lib/vapoursynth/
        doexe ${LIBNAMESC} ${LIBNAMETS}
        dodoc readme_temporalsoften.txt readme.txt

}