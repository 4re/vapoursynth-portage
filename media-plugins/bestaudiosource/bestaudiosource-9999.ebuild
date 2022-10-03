# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Audio source plugin for Vapoursynth"
HOMEPAGE="https://github.com/vapoursynth/bestaudiosource"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/bestaudiosource.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/vapoursynth/bestaudiosource/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth:0/4
	media-video/ffmpeg
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
