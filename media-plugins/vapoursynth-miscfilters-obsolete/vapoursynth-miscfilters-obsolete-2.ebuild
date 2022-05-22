# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Miscellaneous Filters is a random collection of filters that mostly are useful for Avisynth compatibility"
HOMEPAGE="https://github.com/vapoursynth/vs-miscfilters-obsolete"

EGIT_REPO_URI="https://github.com/vapoursynth/vs-miscfilters-obsolete.git"
EGIT_COMMIT="07e0589a381f7deb3bf533bb459a94482bccc5c7"
KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-2.1"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth:0/4
"
DEPEND="${RDEPEND}
"

DOCS=( "docs/misc.rst" )


src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
