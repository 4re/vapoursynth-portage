# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1

DESCRIPTION="TTempSmooth is a motion adaptive temporal smoothing filter"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TTempSmooth"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

src_prepare() {
	default
	local install_path="$(vapoursynth get-plugin-dir)"

	sed -i "s|install_dir = vapoursynth_dep.get_variable(pkgconfig: 'libdir') / 'vapoursynth'|install_dir = '${install_path}'|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
