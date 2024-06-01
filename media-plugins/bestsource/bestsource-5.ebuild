# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Sample/frame accurate access to audio and video source plugin for VaporSynth"
HOMEPAGE="https://github.com/vapoursynth/bestsource"

EGIT_REPO_URI="https://github.com/vapoursynth/bestsource.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="ff911facd49bd4edca253e1fd6e3d140ba668366"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	dev-libs/jansson
	dev-libs/xxhash
	media-libs/vapoursynth:0/4
	>=media-video/ffmpeg-6.1
"
DEPEND="${RDEPEND}
"


src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
