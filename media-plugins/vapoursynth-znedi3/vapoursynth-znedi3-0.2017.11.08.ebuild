# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Optimized nnedi3 filter"
HOMEPAGE="https://github.com/sekrit-twc/znedi3"

EGIT_REPO_URI="https://github.com/sekrit-twc/znedi3.git"
EGIT_COMMIT="c1e672f5fe87d3f7aba3b8f22300bff0e2329378"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_install() {
	insinto "/usr/$(get_libdir)/vapoursynth/"
	doins vsznedi3.so
}
