# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="Fix Telecined Fades"
HOMEPAGE="https://github.com/IFeelBloated/Fix-Telecined-Fades"

EGIT_REPO_URI="https://github.com/IFeelBloated/Fix-Telecined-Fades"
EGIT_COMMIT="e70d7fb759cf0109c8ed74a446c94124aa6b1201"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	dev-lang/yasm
"

DOCS=( "README.md" )


src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
