# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="threads(+)"

inherit autotools python-single-r1

DESCRIPTION="VapourSynth is an library for video manipulation."
HOMEPAGE="http://www.vapoursynth.com/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/${PN}/${PN}/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1 OFL-1.1"
SLOT="0/3"
VSPLUGINS="
	+vapoursynth_plugins_eedi3
	+vapoursynth_plugins_imagemagick
	+vapoursynth_plugins_miscfilters
	+vapoursynth_plugins_morpho
	+vapoursynth_plugins_ocr
	+vapoursynth_plugins_removegrain
	+vapoursynth_plugins_subtext
	+vapoursynth_plugins_vinverse
	+vapoursynth_plugins_vivtc
"
IUSE="doc +vspipe -debug -guard +shared -static cpu_flags_x86_sse2 ${VSPLUGINS}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND+="${PYTHON_DEPS}
	vapoursynth_plugins_subtext? (
		media-libs/libass
		virtual/ffmpeg
	)
	vapoursynth_plugins_imagemagick? ( >=media-gfx/imagemagick-7.0[cxx,hdri,-q8(-),-q64(-)] )
	>=media-libs/zimg-2.9.3
	vapoursynth_plugins_ocr? ( app-text/tesseract )
	vapoursynth_plugins_miscfilters? ( !media-plugins/vapoursynth-miscfilters )
"
DEPEND="${RDEPEND}
	>=dev-python/cython-0.29
	doc? (
		dev-python/sphinx
		dev-python/sphinxcontrib-websupport
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
	emake
	use doc && emake -C "${S}/doc" html
}

src_install() {
	emake DESTDIR="${D}" install
	use doc && HTML_DOCS="${S}/doc/_build/html/" einstalldocs
}
