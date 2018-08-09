# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit python-utils-r1 python-single-r1 toolchain-funcs multilib eutils

DESCRIPTION="Takes several frames and for each pixel calculates linear approximation of its values through time"
HOMEPAGE="https://bitbucket.org/mystery_keeper/templinearapproximate-vapoursynth"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/mystery_keeper/templinearapproximate-vapoursynth.git"
else
	inherit vcs-snapshot
	SRC_URI="https://bitbucket.org/mystery_keeper/templinearapproximate-vapoursynth/get/r${PV}.tar.bz2 -> ${PN}-${PV}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
"

LIBNAME="libtemplinearapproximate.so"

src_compile() {
	$(tc-getCC) -shared -fPIC ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) src/processplane.c src/main.c || die "Build failed"
}

src_install() {
	python_domodule MCDenoise.py
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe ${LIBNAME}
	dodoc TempLinearApproximate-readme.txt
}
