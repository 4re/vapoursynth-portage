# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-multilib

DESCRIPTION="Scaling, colorspace conversion, and dithering library"
HOMEPAGE="https://github.com/sekrit-twc/zimg"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sekrit-twc/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/sekrit-twc/${PN}/archive/release-${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="WTFPL-2"
SLOT="0"
IUSE="static-libs cpu_flags_x86_sse -cli -debug"

RDEPEND+=""
DEPEND="${RDEPEND}"

DOCS=( README.md COPYING )

src_configure() {
	autotools-multilib_src_configure \
		$(use_enable cpu_flags_x86_sse x86simd) \
		$(use_enable debug) \
		$(use_enable cli testapp)
}
