# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="3:3.3"
RESTRICT_PYTHON_ABIS="2.* 3.[0123]"

inherit python git-2

DESCRIPTION="Takes several frames and for each pixel calculates linear approximation of its values through time"
HOMEPAGE="https://bitbucket.org/mystery_keeper/templinearapproximate-vapoursynth"
EGIT_REPO_URI="https://bitbucket.org/mystery_keeper/templinearapproximate-vapoursynth.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

LIBNAME="libtemplinearapproximate.so"

src_compile() {
	$(tc-getCC) -shared -fPIC ${CFLAGS} ${LDFLAGS} -o ${LIBNAME} $(pkg-config --cflags vapoursynth) src/processplane.c src/main.c || die "Build failed"
}

src_install() {
	insinto "$(python_get_sitedir)"
	doins MCDenoise.py
	exeinto /usr/lib/vapoursynth/
	doexe ${LIBNAME}
	dodoc TempLinearApproximate-readme.txt LICENSE
}
