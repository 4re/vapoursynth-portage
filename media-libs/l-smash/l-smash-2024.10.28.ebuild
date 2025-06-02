# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Media library"
HOMEPAGE="https://github.com/vimeo/l-smash"

inherit git-r3

EGIT_REPO_URI="https://github.com/vimeo/${PN}.git"
EGIT_COMMIT="30270d0d8b551b36b6f46c43bd3ffe997f13e157"

KEYWORDS="~amd64 ~x86"

LICENSE="ISC"
SLOT="0"
IUSE="-static-libs -debug"

RDEPEND+="
	media-video/ffmpeg
	media-libs/obuparse
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	local myconf="--enable-shared"

	if ! use static-libs; then
		myconf="${myconf} --disable-static"
	fi
	if use debug; then
		myconf="${myconf} --enable-debug"
	fi

	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--extra-cflags="${CFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		${myconf}  || die
}
