# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1

DESCRIPTION="TFM and TDecimate functions for field matching and decimation"
HOMEPAGE="https://github.com/dubhater/vapoursynth-tivtc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-tivtc"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-tivtc/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP},legacy]
"
DEPEND="${RDEPEND}
"

src_prepare() {
	default
	local install_path="$(vapoursynth get-plugin-dir)"
	sed -i "s|cpp_args: cflags,$|cpp_args: cflags,\n              install_dir : '${install_path}',|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
