# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ColorBars is a filter for generating test signals"
HOMEPAGE="https://github.com/ifb/vapoursynth-colorbars"

inherit git-r3
EGIT_REPO_URI="https://github.com/ifb/vapoursynth-colorbars.git"
EGIT_COMMIT="47db7edba3639d1a7be60e90d538adb50c1f67a4"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth:0/4
"
DEPEND="${RDEPEND}
"


src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
}
