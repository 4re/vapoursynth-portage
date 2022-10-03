# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Image super-resolution/denoise filter for VapourSynth, based on the waifu2x-opt library"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Waifu2x-w2xc"

EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
EGIT_COMMIT="a9f064adbbd2930ac717bb2e1667b71783587bce"
KEYWORDS="~x86 ~amd64"

LICENSE="MIT"
SLOT="0"
IUSE="debug lto"

RDEPEND+="
	media-libs/vapoursynth
	>=media-libs/waifu2x-converter-cpp-5.2.1
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )


src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
