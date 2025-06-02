# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/dwbuiten/obuparse.git"
GIT_COMMIT="d17f1d20df390784400521ba3a1eb46d568cc40d"

DESCRIPTION="A simple and portable single file AV1 OBU parser."
HOMEPAGE="https://github.com/dwbuiten/obuparse"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


src_install() {
	dolib.a "lib${PN}.a"
	dolib.so "lib${PN}.so"
	dosym "lib${PN}.so" "/usr/$(get_libdir)/lib${PN}.so.1"
	doheader "${PN}.h"
}
