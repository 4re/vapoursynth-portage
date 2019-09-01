# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="Works based on L-SMASH project"
HOMEPAGE="https://github.com/HolyWu/L-SMASH-Works"

EGIT_REPO_URI="https://github.com/HolyWu/L-SMASH-Works.git"
EGIT_COMMIT="fd471fcff30c71dcfcb580909cd17261954b4b54"

KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND+="
	media-video/ffmpeg
	media-libs/l-smash
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/${P}/VapourSynth"

PATCHES=(
	"${FILESDIR}/${PN}-strings.patch"
)
