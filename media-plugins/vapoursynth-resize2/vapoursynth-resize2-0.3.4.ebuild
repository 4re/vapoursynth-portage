# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Dependency for vs-jetpack"
HOMEPAGE="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}"
RESTRICT="network-sandbox"

src_prepare() {
	default

	# Pulled from AUR
	sed -i "s|link_args: \['-static'],|#link_args: \['-static'],|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure --wrap-mode=default
}
