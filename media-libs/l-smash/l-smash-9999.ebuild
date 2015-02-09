# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="Media library"
HOMEPAGE="https://github.com/l-smash/l-smash"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="+shared -static -debug"

RDEPEND+="
	>=virtual/ffmpeg-9
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	local myconf

	if ! use static; then
		myconf="${myconf} --disable-static"
	fi
	if use shared; then
		myconf="${myconf} --enable-shared"
	fi
	if use debug; then
		myconf="${myconf} --enable-debug"
	fi

	./configure --prefix=/usr --libdir=/usr/$(get_libdir) ${myconf} --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}
