# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-utils-r1 python-single-r1

DESCRIPTION="A scene change detection plugin for VapourSynth plus temporalsoften2 that makes use of it"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166769"
SRC_URI="https://www.dropbox.com/s/ga3r71xgh76f16r/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
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
	python_domodule temporalsoften2.py
	exeinto "/usr/$(get_libdir)/vapoursynth/"
	doexe ${LIBNAMESC} ${LIBNAMETS}
	dodoc readme_temporalsoften.txt readme.txt
}
