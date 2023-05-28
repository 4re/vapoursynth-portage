# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="TFM and TDecimate functions for field matching and decimation"
HOMEPAGE="https://github.com/AmusementClub/vcm http://www.avisynth.nl/users/vcmohan/vcm/vcm.html"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AmusementClub/vcm"
	KEYWORDS=""
else
	SRC_URI="https://github.com/AmusementClub/vcm/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw
"
DEPEND="${RDEPEND}
"

src_prepare() {
	sed -i -e "s:#install:install:g" meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
