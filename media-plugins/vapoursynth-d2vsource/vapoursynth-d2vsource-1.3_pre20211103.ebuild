# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="D2V Source plugin for VapourSynth"
HOMEPAGE="https://github.com/dwbuiten/d2vsource"

EGIT_REPO_URI="https://github.com/dwbuiten/d2vsource.git"
EDIT_COMMIT="700523ca0eb4232ae624f12dd81b23ab52517534"
KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth:0/4
	media-video/ffmpeg
"
DEPEND="${RDEPEND}
"

DOCS=( README )


src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf  --libdir="/usr/$(get_libdir)/vapoursynth/"
}
