# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Raw format video reader for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/vsrawsource"
EGIT_REPO_URI="https://github.com/myrsloik/vsrawsource"
#EGIT_REPO_URI="https://github.com/chikuzen/vsrawsource.git"

inherit git-2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	./configure --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}"
}

src_compile() {
	emake || die
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe libvsrawsource.so
	dodoc format_list.txt readme.rst
}
