# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools multilib-minimal

if [[ ${PV} = *9999* ]] ; then
	EGIT_REPO_URI="https://github.com/sekrit-twc/zimg"
	inherit git-r3
else
	SRC_URI="https://github.com/sekrit-twc/zimg/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha amd64 arm arm64 hppa ppc ppc64 sparc x86"
	S="${WORKDIR}/${PN}-release-${PV}/"
fi

DESCRIPTION="Scaling, colorspace conversion, and dithering library"
HOMEPAGE="https://github.com/sekrit-twc/zimg"

LICENSE="WTFPL-2"
SLOT="0"
IUSE="cpu_flags_x86_sse debug static-libs"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable debug) \
		$(use_enable cpu_flags_x86_sse simd) \
		$(use_enable static-libs static)
}
