# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1

PYTHON_COMPAT=( python3_{4,5} )
PYTHON_REQ_USE="threads(+)"

inherit autotools-utils python-single-r1

DESCRIPTION="VapourSynth is an library for video manipulation."
HOMEPAGE="http://www.vapoursynth.com/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/${PN}/${PN}/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc +assvapour +eedi3 +imagemagick +morpho +ocr +removegrain +vinverse +vivtc +shared +vspipe +x86-asm -debug -guard -static"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND+="${PYTHON_DEPS}
	assvapour? ( media-libs/libass )
	imagemagick? ( media-gfx/imagemagick[-q8,-q32,-q64] )
	ocr? ( app-text/tesseract )
"
DEPEND="${RDEPEND}
	x86? ( dev-lang/yasm )
	amd64? ( dev-lang/yasm )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	virtual/ffmpeg
	virtual/pkgconfig
	dev-python/cython
"

# bug with MAKEOPTS="-j1"
AUTOTOOLS_IN_SOURCE_BUILD=1

PATCHES=(
	"${FILESDIR}/${P}-hdri.patch"
	"${FILESDIR}/${P}-c98.patch"
	"${FILESDIR}/${P}-vdecimate-duration.patch"
)

src_configure() {
	autotools-utils_src_configure \
		--enable-core \
		--enable-python-module \
		--enable-vsscript \
		$( use_enable assvapour ) \
		$( use_enable eedi3 ) \
		$( use_enable imagemagick imwri ) \
		$( use_enable morpho ) \
		$( use_enable ocr ) \
		$( use_enable removegrain ) \
		$( use_enable vinverse ) \
		$( use_enable vivtc ) \
		$( use_enable shared ) \
		$( use_enable static ) \
		$( use_enable debug ) \
		$( use_enable guard guard-pattern ) \
		$( use_enable x86-asm ) \
		$( use_enable vspipe )
}

src_compile() {
	autotools-utils_src_compile
	use doc && autotools-utils_src_compile -C "${S}/doc" html
}

src_install() {
	use doc && HTML_DOCS=("${S}/doc/_build/html")
	autotools-utils_src_install
}
