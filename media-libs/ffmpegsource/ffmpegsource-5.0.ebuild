# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic vcs-snapshot

DESCRIPTION="A libav/ffmpeg based source library for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"
SRC_URI="https://github.com/FFMS/ffms2/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/4"
KEYWORDS="amd64 x86"

RDEPEND="
	sys-libs/zlib
	>=media-video/ffmpeg-6.1
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	default_src_prepare
	./autogen.sh
	eautoreconf
}

src_install() {
	default_src_install
	find "${ED}" -name '*.la' -delete || die
}
