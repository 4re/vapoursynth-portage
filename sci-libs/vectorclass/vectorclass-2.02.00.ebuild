# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Vector class library"
HOMEPAGE="https://github.com/vectorclass/version2"

if ver_test -ne 9999; then
	SRC_URI="https://github.com/vectorclass/version2/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vectorclass/version2.git"
	KEYWORDS=""
fi

LICENSE="Apache-2.0"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

if ver_test -ne 9999; then
	S="${WORKDIR}/version2-${PV}"
fi

src_install() {
	doheader *.h
}
