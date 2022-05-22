# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Histogram plugin for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-histogram"

inherit git-r3

EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
EGIT_COMMIT="c15398b1ceb3c4debb63f29ab3d0fa1c84cb0436"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
