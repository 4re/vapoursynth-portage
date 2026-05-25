# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson git-r3 python-single-r1

DESCRIPTION="Miscellaneous Filters is a random collection of filters that mostly are useful for Avisynth compatibility"
HOMEPAGE="https://github.com/vapoursynth/vs-miscfilters-obsolete"

EGIT_REPO_URI="https://github.com/vapoursynth/vs-miscfilters-obsolete.git"
EGIT_COMMIT="07e0589a381f7deb3bf533bb459a94482bccc5c7"
KEYWORDS="~amd64 ~x86"

LICENSE="LGPL-2.1"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "docs/misc.rst" )

src_prepare() {
	default
	local install_path="$(vapoursynth get-plugin-dir)"
	sed -i "s|install_dir : join_paths(dep.get_pkgconfig_variable('libdir'), 'vapoursynth')|install_dir : '${install_path}'|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
