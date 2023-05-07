# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Sample/frame accurate access to audio and video source plugin for VaporSynth"
HOMEPAGE="https://github.com/vapoursynth/bestsource"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/bestsource.git https://github.com/sekrit-twc/libp2p"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/vapoursynth/bestsource/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	dev-libs/jansson
	media-libs/vapoursynth:0/4
	media-video/ffmpeg
"
DEPEND="${RDEPEND}
"

src_unpack() {
	git-r3_fetch
	git-r3_checkout
	git-r3_fetch "https://github.com/sekrit-twc/libp2p.git" "5e65679ae54d0f9fa412ab36289eb2255e341625"
	git-r3_checkout "https://github.com/sekrit-twc/libp2p.git" "${S}/libp2p"
}

src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
