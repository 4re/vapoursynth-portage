# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1 git-r3

DESCRIPTION="TFM and TDecimate functions for field matching and decimation"
HOMEPAGE="https://github.com/AmusementClub/vcm http://www.avisynth.nl/users/vcmohan/vcm/vcm.html"

EGIT_REPO_URI="https://github.com/AmusementClub/vcm"
KEYWORDS=""

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
	sci-libs/fftw
"
DEPEND="${RDEPEND}
"

src_prepare() {
	sed -i -e "s:#install:install:g" meson.build || die
	sed -i "s|#install_dir:|install_dir:|" meson.build || die

	local install_path="$(vapoursynth get-plugin-dir)"
	elog ${install_path}
	sed -i "s|install_dir = join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')|install_dir = '${install_path}'|" meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
