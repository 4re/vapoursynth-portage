# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="libplacebo-based debanding, scaling and color mapping plugin for VapourSynth"
HOMEPAGE="https://github.com/Lypheo/vs-placebo"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Lypheo/vs-placebo.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Lypheo/vs-placebo/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
