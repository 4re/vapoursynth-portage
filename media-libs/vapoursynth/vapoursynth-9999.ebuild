# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

AUTOTOOLS_AUTORECONF=1

PYTHON_COMPAT=( python3_{4,5,6} )
PYTHON_REQ_USE="threads(+)"

inherit autotools-utils python-single-r1

DESCRIPTION="VapourSynth is an library for video manipulation."
HOMEPAGE="http://www.vapoursynth.com/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
# 	EGIT_COMMIT=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/${PN}/${PN}/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1 OFL-1.1"
SLOT="0"
VSPLUGINS="
	vapoursynth_plugins_eedi3
	vapoursynth_plugins_imagemagick
	vapoursynth_plugins_miscfilters
	vapoursynth_plugins_morpho
	vapoursynth_plugins_ocr
	vapoursynth_plugins_removegrain
	vapoursynth_plugins_subtext
	vapoursynth_plugins_vinverse
	vapoursynth_plugins_vivtc
"
IUSE="doc +vspipe -debug -guard +shared -static ${VSPLUGINS}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND+="${PYTHON_DEPS}
	vapoursynth_plugins_subtext? (
		media-libs/libass
		virtual/ffmpeg
	)
	vapoursynth_plugins_imagemagick? ( >=media-gfx/imagemagick-7.0.0.0[cxx,hdri,-q8(-),-q64(-)] )
	>=media-libs/zimg-2.7
	vapoursynth_plugins_ocr? ( app-text/tesseract )
	vapoursynth_plugins_miscfilters? ( !media-plugins/vapoursynth-miscfilters )
"
DEPEND="${RDEPEND}
	>=dev-python/cython-0.28.2
	doc? (
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinxcontrib-websupport[${PYTHON_USEDEP}]
	)
	virtual/pkgconfig
	>=dev-lang/nasm-2.13.01
"

# bug with MAKEOPTS="-j1"
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	autotools-utils_src_configure \
		--enable-core \
		--enable-python-module \
		--enable-vsscript \
		--enable-x86-asm \
		$( use_enable vapoursynth_plugins_eedi3 eedi3 ) \
		$( use_enable vapoursynth_plugins_imagemagick imwri ) \
		$( use_enable vapoursynth_plugins_miscfilters miscfilters ) \
		$( use_enable vapoursynth_plugins_morpho morpho ) \
		$( use_enable vapoursynth_plugins_ocr ocr ) \
		$( use_enable vapoursynth_plugins_removegrain removegrain ) \
		$( use_enable vapoursynth_plugins_subtext subtext ) \
		$( use_enable vapoursynth_plugins_vinverse vinverse ) \
		$( use_enable vapoursynth_plugins_vivtc vivtc ) \
		$( use_enable shared ) \
		$( use_enable static ) \
		$( use_enable debug ) \
		$( use_enable guard guard-pattern ) \
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
