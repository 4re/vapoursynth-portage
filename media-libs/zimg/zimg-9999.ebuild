# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 autotools

DESCRIPTION="Scaling, colorspace conversion, and dithering library"
HOMEPAGE="https://github.com/sekrit-twc/zimg"
EGIT_REPO_URI="https://github.com/sekrit-twc/zimg.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-cli"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	./autogen.sh || die
}

src_configure() {
	econf \
		$( use_enable cli testapp ) || die
}

src_install() {
    emake DESTDIR="${D}" install || die
    dodoc README.md COPYING || die
    dosym /usr/lib64/zimg/vszimg.so /usr/lib64/vapoursynth/vszimg.so || die
}
