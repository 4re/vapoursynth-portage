# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

DESCRIPTION="Scaling, colorspace conversion, and dithering library"
HOMEPAGE="https://github.com/sekrit-twc/zimg"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sekrit-twc/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/sekrit-twc/${PN}/archive/release-${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-cli -debug"

RDEPEND+="
"
DEPEND="${RDEPEND}
"

DOCS=( README.md COPYING )

src_configure() {
	local myeconfargs=(
			$(use_enable debug)
			$(use_enable cli testapp)
	)
	autotools-utils_src_configure
}
