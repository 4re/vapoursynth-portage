# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python3_{4,5,6} )
PYTHON_REQ_USE="threads(+)"

inherit python-any-r1 multilib waf-utils git-r3

DESCRIPTION="A deband library and filter for VapourSynth"
HOMEPAGE="https://github.com/SAPikachu/flash3kyuu_deband"
EGIT_REPO_URI="https://github.com/SAPikachu/flash3kyuu_deband.git"
EGIT_COMMIT="9f3042e0a1d8e816164644174d3e80795078322a"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="
	${PYTHON_DEPS}
	${RDEPEND}
	doc? ( dev-python/sphinx )
	virtual/pkgconfig
"

src_compile() {
	waf-utils_src_compile || die
	if use doc; then
		sphinx-build -b html -d docs/_build/doctrees docs/source/ docs/_build/html
	fi
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe build/libf3kdb.so
	if use doc; then
		dohtml -r docs/_build/html/*
	fi
}
