# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A spatial smoothing filter that uses the bilateral filtering algorithm"
HOMEPAGE="https://github.com/dubhater/vapoursynth-tbilateral"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-tbilateral.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-tbilateral/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
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
