# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="libplacebo-based debanding, scaling and color mapping plugin for VapourSynth"
HOMEPAGE="https://github.com/Lypheo/vs-placebo"

EGIT_REPO_URI="https://github.com/Lypheo/vs-placebo.git"
EGIT_COMMIT="2a88143033584f21cc35c13f54b140de4a44621a"
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
