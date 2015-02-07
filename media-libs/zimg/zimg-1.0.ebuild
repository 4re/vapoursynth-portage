# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

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
IUSE="-cli"

RDEPEND+="
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
}
