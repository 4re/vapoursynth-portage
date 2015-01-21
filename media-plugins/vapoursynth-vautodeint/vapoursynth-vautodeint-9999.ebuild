# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="3:3.3"
RESTRICT_PYTHON_ABIS="2.* 3.[0123]"

inherit python git-2

DESCRIPTION="Auto interlace detection and deinterlace vapoursynth python script"
HOMEPAGE="https://github.com/gnaggnoyil/VAutoDeint"
EGIT_REPO_URI="https://github.com/gnaggnoyil/VAutoDeint.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libvautodeint.so"

EXTRAFLAGS="-std=gnu99 -fPIC -shared"


src_compile(){
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) externalfilters/*.cpp || die "Build failed"
}


src_install(){
	insinto "$(python_get_sitedir)"
	doins  VAutoDeint.py
        exeinto /usr/lib/vapoursynth/
        doexe ${LIBNAME}
        dodoc README

}
