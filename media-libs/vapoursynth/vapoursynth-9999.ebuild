# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit autotools git-2 flag-o-matic

DESCRIPTION="VapourSynth is an library for video manipulation."
HOMEPAGE="http://www.vapoursynth.com/"
EGIT_REPO_URI="https://github.com/vapoursynth/vapoursynth.git"
#EGIT_COMMIT="1a1d5dca0114dbc8536e74efe193be5549fb009c"

LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE="+doc +plugins +shared +vspipe +x86-asm -debug -static -tcmalloc"
SLOT="0"

RDEPEND+="
	plugins? ( media-libs/libass )
	plugins? ( media-gfx/imagemagick )
	plugins? ( app-text/tesseract )
"
DEPEND="${RDEPEND}
    doc? ( dev-python/sphinx )
	virtual/pkgconfig
	dev-lang/yasm
	dev-python/cython
"


src_prepare() {
	./autogen.sh || die
#	sed -i 's/#include <string.h>/#include <cstring>/g' src/core/vscore.h || die
}

src_configure() {
	use tcmalloc && append-flags -ltcmalloc

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
    if use doc; then
        emake -C doc/ html || die "emake doc failed"
    fi
}

src_install() {
    emake DESTDIR="${D}" install
    dodoc ChangeLog COPYING.LGPLv2.1
    if use doc; then
        dohtml -r doc/_build/html/*
    fi
}
