# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="TemporalSoften filter for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-temporalsoften2"

EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
EGIT_COMMIT="a133670676a311dde31b0eb1a771bbd94ffb1235"
KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-2.1"
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
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
