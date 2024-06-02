# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1

DESCRIPTION="A scene change detection plugin and script for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166769"
SRC_URI="https://www.dropbox.com/s/ga3r71xgh76f16r/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-temporalsoften2
"
DEPEND="${RDEPEND}
"

LIBNAMESC="libscenechange.so"
EXTRAFLAGS="-std=gnu99 -fPIC -ffast-math -fexcess-precision=fast -shared"

src_compile(){
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAMESC} $(pkg-config --cflags vapoursynth) src/scenechange.c || die "Build for scenechange failed"
}

src_install(){
	python_domodule temporalsoften2.py
	exeinto "/usr/$(get_libdir)/vapoursynth/"
	doexe ${LIBNAMESC}
	dodoc readme_temporalsoften.txt readme.txt
}
