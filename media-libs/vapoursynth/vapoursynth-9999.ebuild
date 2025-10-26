# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="threads(+)"

inherit autotools python-single-r1

DESCRIPTION="VapourSynth is an library for video manipulation."
HOMEPAGE="http://www.vapoursynth.com/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/${PN}/${PN}/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1 OFL-1.1"
SLOT="0/4"
IUSE="doc +vspipe -debug -guard +shared -static-libs cpu_flags_x86_sse2"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND+="${PYTHON_DEPS}
	>=media-libs/zimg-3.0.5
"
DEPEND="${RDEPEND}
	dev-python/cython
	doc? (
		dev-python/sphinx
		dev-python/sphinx_rtd_theme
	)
	virtual/pkgconfig
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--enable-core \
		--enable-python-module \
		--enable-vsscript \
		$( use_enable cpu_flags_x86_sse2 x86-asm ) \
		$( use_enable shared ) \
		$( use_enable static-libs static ) \
		$( use_enable debug ) \
		$( use_enable guard guard-pattern ) \
		$( use_enable vspipe )
}

src_compile() {
	emake
	use doc && emake -C "${S}/doc" html
}

src_install() {
	emake DESTDIR="${D}" install
	use doc && HTML_DOCS="${S}/doc/_build/html/" einstalldocs
}
