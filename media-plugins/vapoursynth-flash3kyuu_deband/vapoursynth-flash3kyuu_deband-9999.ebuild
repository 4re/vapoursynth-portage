# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"

inherit python-any-r1 multilib waf-utils

DESCRIPTION="A deband library and filter for VapourSynth"
HOMEPAGE="https://github.com/SAPikachu/flash3kyuu_deband"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/SAPikachu/flash3kyuu_deband.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/SAPikachu/flash3kyuu_deband/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
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
