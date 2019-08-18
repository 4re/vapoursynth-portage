# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="D2V Source plugin for VapourSynth"
HOMEPAGE="https://github.com/dwbuiten/d2vsource"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dwbuiten/d2vsource.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dwbuiten/d2vsource/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	>=virtual/ffmpeg-9
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
