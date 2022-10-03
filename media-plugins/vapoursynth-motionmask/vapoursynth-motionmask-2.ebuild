# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Creates a mask of moving pixels. Every output pixel will be set to the absolute difference between the current frame and the previous frame"
HOMEPAGE="https://github.com/dubhater/vapoursynth-motionmask"

EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
EGIT_COMMIT="ed86b06688c2db1b05d7026f66a2574e64c9e69e"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

DOCS=( "readme.rst" )


src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
