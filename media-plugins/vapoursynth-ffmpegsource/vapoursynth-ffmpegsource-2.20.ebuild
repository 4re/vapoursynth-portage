# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib

DESCRIPTION="A libav/ffmpeg based source library for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	=media-libs/ffmpegsource-${PV}
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}"

src_install() {
	dosym /usr/$(get_libdir)/libffms2.so.3.0.0 /usr/$(get_libdir)/vapoursynth/libffms2.so || die
}
