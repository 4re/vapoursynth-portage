# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="Allows easy remapping of frames in a clip through the use of a text file or an input string"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-RemapFrames"

EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-RemapFrames"
EGIT_COMMIT="86690006b74a5d2165e2f9854b2a183c600e69d7"

KEYWORDS="~amd64 ~x86"

LICENSE="BSD-2"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

DOCS=( "README.rst" )


src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}

