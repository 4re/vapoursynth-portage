# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Image reader and writer for VapourSynth using the ImageMagick library"
HOMEPAGE="https://github.com/vapoursynth/vs-imwri"

EGIT_REPO_URI="https://github.com/vapoursynth/vs-imwri.git"
EGIT_COMMIT="3042a327739e44b929f5ab02ff1da4d8de5ee061"
KEYWORDS="~x86 ~amd64"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="lto heif jxl tiff"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth:0/4
	heif? ( media-libs/libheif )
	jxl? ( media-libs/libjxl )
	tiff? ( media-libs/tiff )
	media-gfx/imagemagick[cxx,hdri,heif,tiff,-q8(-),-q64(-)]
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
