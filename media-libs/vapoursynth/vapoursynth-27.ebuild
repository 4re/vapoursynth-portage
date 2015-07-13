# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1

PYTHON_COMPAT=( python3_4 )

inherit autotools-utils python-r1

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
IUSE="+doc +plugins +imagemagick +shared +vspipe +x86-asm -debug -static"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND+="${PYTHON_DEPS}
	plugins? ( media-libs/libass )
	imagemagick? ( media-gfx/imagemagick[-hdri,-q8,-q32,-q64] )
	plugins? ( app-text/tesseract )
"
DEPEND="${RDEPEND}
	x86? ( dev-lang/yasm )
	amd64? ( dev-lang/yasm )
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	virtual/ffmpeg
	virtual/pkgconfig
	dev-python/cython
"

src_configure() {
	autotools-utils_src_configure \
		--enable-core \
		--enable-python-module \
		--enable-vsscript \
		$( use_enable plugins ) \
		$( use_enable imagemagick imwri ) \
		$( use_enable shared ) \
		$( use_enable static ) \
		$( use_enable debug ) \
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
