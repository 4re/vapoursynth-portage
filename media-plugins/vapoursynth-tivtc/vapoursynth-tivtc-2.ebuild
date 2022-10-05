# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="TFM and TDecimate functions for field matching and decimation"
HOMEPAGE="https://github.com/dubhater/vapoursynth-tivtc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-tivtc"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-tivtc/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
