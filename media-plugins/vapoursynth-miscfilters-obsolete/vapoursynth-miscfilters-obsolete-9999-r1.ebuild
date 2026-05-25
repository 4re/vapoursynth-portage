# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1

DESCRIPTION="Miscellaneous Filters is a random collection of filters that mostly are useful for Avisynth compatibility"
HOMEPAGE="https://github.com/vapoursynth/vs-miscfilters-obsolete"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/vs-miscfilters-obsolete.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/vapoursynth/vs-miscfilters-obsolete/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
	sed -i "s|join_paths(dep.get_pkgconfig_variable('libdir'), 'vapoursynth')|'${install_path}'|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
