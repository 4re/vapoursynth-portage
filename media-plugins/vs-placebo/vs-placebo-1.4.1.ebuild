# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="libplacebo-based debanding, scaling and color mapping plugin for VapourSynth"
HOMEPAGE="https://github.com/Lypheo/vs-placebo"

EGIT_REPO_URI="https://github.com/Lypheo/vs-placebo.git"
EGIT_COMMIT="0633d39ed91b18d2393a5e695dc2777d4bb024f5"
KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/libplacebo-4.192.1
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )


src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
