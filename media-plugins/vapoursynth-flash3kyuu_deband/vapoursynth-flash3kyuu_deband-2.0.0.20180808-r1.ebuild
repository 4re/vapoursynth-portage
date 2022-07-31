# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
PYTHON_REQ_USE="threads(+)"

WAF_PV=2.0.23

inherit python-any-r1 multilib waf-utils git-r3

DESCRIPTION="A deband library and filter for VapourSynth"
HOMEPAGE="https://github.com/SAPikachu/flash3kyuu_deband"
EGIT_REPO_URI="https://github.com/SAPikachu/flash3kyuu_deband.git"
EGIT_COMMIT="c57e9d6a535ec9a85fb5415a405f099cbe69f535"
SRC_URI+=" https://waf.io/waf-${WAF_PV}"

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

src_prepare() {
	cp "${DISTDIR}/waf-${WAF_PV}" "${S}"/waf || die
	chmod +x "${S}"/waf || die
	default
}

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
