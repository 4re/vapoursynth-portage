# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1 toolchain-funcs multilib

DESCRIPTION="Auto interlace detection and deinterlace vapoursynth python script"
HOMEPAGE="https://github.com/gnaggnoyil/VAutoDeint"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gnaggnoyil/VAutoDeint.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/gnaggnoyil/VAutoDeint/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

LIBNAME="libvautodeint.so"
EXTRAFLAGS="-fPIC -shared"

src_compile(){
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) externalfilters/*.cpp || die "Build failed"
}

src_install(){
	python_domodule VAutoDeint.py
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
	dodoc README
}
