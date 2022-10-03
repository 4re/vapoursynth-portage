# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Frfun7 is a spatial fractal denoising plugin"
HOMEPAGE="https://github.com/dubhater/vapoursynth-frfun7"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-frfun7.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-frfun7/archive/refs/tags/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth:0/4
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
