# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Media library"
HOMEPAGE="https://github.com/l-smash/l-smash"
EGIT_REPO_URI="https://github.com/l-smash/l-smash.git"

LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE="-debug"
SLOT="0"

RDEPEND+="
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=virtual/ffmpeg-9
"

src_configure() {
	./configure --prefix=/usr --prefix=/usr --libdir=/usr/lib64 --enable-shared --disable-static --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

#src_compile() {
#	waf-utils_src_compile || die
#	./setup.py build || die
#}

#src_install() {
#	waf-utils_src_install || die
#	python_domodule build/lib.linux-x86_64-3.3/*.so
#}
