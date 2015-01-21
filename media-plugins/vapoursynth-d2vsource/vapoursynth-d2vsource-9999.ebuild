# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="D2V Source plugin for VapourSynth"
HOMEPAGE="https://github.com/dwbuiten/d2vsource"
EGIT_REPO_URI="https://github.com/dwbuiten/d2vsource.git"

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
	./configure --install="/usr/lib/vapoursynth" --extra-cxxflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_install() {
        exeinto /usr/lib/vapoursynth/
        doexe libd2vsource.so
	dodoc README
}
