# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Cross-platform D2V creator"
HOMEPAGE="https://github.com/dubhater/D2VWitch"

EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
EGIT_COMMIT="b379384bb6aa7ee475ff7421b0ce5fee9e85d8b6"
KEYWORDS="~amd64 ~x86"

LICENSE="ISC LGPL-2.1"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-video/ffmpeg
"
DEPEND="${RDEPEND}
	dev-qt/qtwidgets
	media-libs/vapoursynth
"

DOCS=( "readme.rst" )

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
