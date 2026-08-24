# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools multilib-minimal git-r3

EGIT_REPO_URI="https://github.com/sekrit-twc/zimg"
EGIT_COMMIT="f6cc75ad23db1bb9c53673c15523e6b6e960ffc6"
DESCRIPTION="Scaling, colorspace conversion, and dithering library"
HOMEPAGE="https://github.com/sekrit-twc/zimg"

KEYWORDS="~alpha amd64 arm arm64 hppa ppc ppc64 sparc x86"

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
