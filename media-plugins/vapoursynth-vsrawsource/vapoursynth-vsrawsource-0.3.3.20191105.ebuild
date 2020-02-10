# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="Raw format video reader for VapourSynth"
HOMEPAGE="https://github.com/HolyWu/vsrawsource"

EGIT_REPO_URI="https://github.com/HolyWu/vsrawsource.git"
EGIT_COMMIT="82400b7ad8e57cb71cc7cde44e36579cf40455f0"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

DOCS=( "readme.rst" "format_list.txt" )


src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
