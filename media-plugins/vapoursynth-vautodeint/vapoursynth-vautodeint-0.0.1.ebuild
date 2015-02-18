# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_4 )

inherit python-utils-r1 python-single-r1 toolchain-funcs multilib

DESCRIPTION="Auto interlace detection and deinterlace vapoursynth python script"
HOMEPAGE="https://github.com/gnaggnoyil/VAutoDeint"
EGIT_REPO_URI="https://github.com/gnaggnoyil/VAutoDeint.git"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gnaggnoyil/VAutoDeint.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/gnaggnoyil/VAutoDeint/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libvautodeint.so"
EXTRAFLAGS="-fPIC -shared"

src_compile(){
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) externalfilters/*.cpp || die "Build failed"
}

src_install(){
	insinto "$(python_get_sitedir)"
	doins  VAutoDeint.py
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
	dodoc README
}
