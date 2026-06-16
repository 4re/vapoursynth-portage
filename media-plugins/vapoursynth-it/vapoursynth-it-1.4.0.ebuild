# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=no

DESCRIPTION="VapourSynth 3:2-pulldown removal for NTSC"
HOMEPAGE="https://github.com/theChaosCoder/vapoursynth-it"

declare -g -r -A ZBS_DEPENDENCIES=(
	[vapoursynth-4.0.0-jLYMQzOOAgDbCgdTQVlOlOZysud-8FD-daGymdAH5Mvc.tar.gz]='https://github.com/dnjulek/vapoursynth-zig/archive/92b85456e3c82e55c21dbc0c213c70ef50164ea4.tar.gz'
)

ZIG_SLOT="0.16"

inherit distutils-r1 zig

SRC_URI="
	https://github.com/theChaosCoder/vapoursynth-it/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror test"

RDEPEND="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"

DOCS=( "README.md" )

src_install() {
	zig_src_install --prefix-lib-dir "$(vapoursynth get-plugin-dir)"
}
