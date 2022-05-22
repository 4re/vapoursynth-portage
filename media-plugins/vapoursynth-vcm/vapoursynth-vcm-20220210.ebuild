# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="TFM and TDecimate functions for field matching and decimation"
HOMEPAGE="https://github.com/AmusementClub/vcm"

EGIT_REPO_URI="https://github.com/AmusementClub/vcm http://www.avisynth.nl/users/vcmohan/vcm/vcm.html"
EGIT_COMMIT="744c82d16728accb43022df9a82e0f609e381617"
KEYWORDS="~amd64"

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	sed -i -e "s:#install:install:g" meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
