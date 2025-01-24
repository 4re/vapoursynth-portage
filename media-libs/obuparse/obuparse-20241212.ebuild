# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GIT_COMMIT="918524abdc19b6582d853c03373d8e2e0b9f11ee"

DESCRIPTION="A simple and portable single file AV1 OBU parser."
HOMEPAGE="https://github.com/dwbuiten/obuparse"
SRC_URI="https://github.com/dwbuiten/obuparse/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${GIT_COMMIT}"

src_install() {
	dolib.a "lib${PN}.a"
	dolib.so "lib${PN}.so"
	dosym "lib${PN}.so" "/usr/$(get_libdir)/lib${PN}.so.1"
	doheader "${PN}.h"
}
