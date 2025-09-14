# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SRC_URI="https://github.com/dwbuiten/obuparse/archive/v${PV}.tar.gz -> ${P}.tar.gz"

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
	dosym "lib${PN}.so" "/usr/$(get_libdir)/lib${PN}.so.2"
	doheader "${PN}.h"
}
