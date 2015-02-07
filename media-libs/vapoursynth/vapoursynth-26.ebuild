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
	#EGIT_COMMIT="1a1d5dca0114dbc8536e74efe193be5549fb009c"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/${PN}/${PN}/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="+doc +plugins +shared +vspipe +x86-asm -debug -static"
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND+="${PYTHON_DEPS}
	plugins? ( media-libs/libass )
	plugins? ( media-gfx/imagemagick )
	plugins? ( app-text/tesseract )
"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	virtual/ffmpeg
	virtual/pkgconfig
	dev-lang/yasm
	dev-python/cython
"

src_configure() {
	econf \
		--enable-core \
		--enable-python-module \
		--enable-vsscript \
		$( use_enable plugins ) \
		$( use_enable shared ) \
		$( use_enable static ) \
		$( use_enable debug ) \
		$( use_enable x86-asm ) \
		$( use_enable vspipe ) || die
}

src_compile() {
	emake || die "emake failed"
	use doc && (emake -C doc html || die)
}

src_install() {
	use doc && (HTML_DOCS=("${S}/doc/_build/html") || die)
	emake DESTDIR="${D}" install
}
