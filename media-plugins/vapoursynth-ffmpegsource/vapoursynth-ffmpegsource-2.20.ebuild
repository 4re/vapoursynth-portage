# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

DESCRIPTION="A libav/ffmpeg based source library for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
    =media-libs/ffmpegsource-${PV}*
    media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}"

src_install() {
    dosym /usr/lib64/libffms2.so.3.0.0 /usr/lib/vapoursynth/libffms2.so || die
}
