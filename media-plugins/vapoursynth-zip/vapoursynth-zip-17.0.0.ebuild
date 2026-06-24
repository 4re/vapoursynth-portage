# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=no

DESCRIPTION="VapourSynth Zig Image Process"
HOMEPAGE="https://github.com/dnjulek/vapoursynth-zip"

declare -g -r -A ZBS_DEPENDENCIES=(
	[vapoursynth-4.0.0-jLYMQ6DjAgDFOODh8tdhWCw0iGHMPKiR4znTJwSyvV36.tar.gz]='https://github.com/dnjulek/vapoursynth-zig/archive/b87ff61ce680fa5a4cf7d44a9cb4b605c5037432.tar.gz'
	[zigimg-0.1.0-8_eo2sGbFwCrsBjkTTP-kinCH62m5vmYDHQnQcngFuwh.tar.gz]='https://github.com/coisos/zigimg/archive/0bbe201a5591219177f2444371c2897746b47774.tar.gz'
)

ZIG_SLOT="0.16"

inherit distutils-r1 zig

SRC_URI="
	https://github.com/dnjulek/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"

DOCS=( "README.md" )

src_install() {
	zig_src_install --prefix-lib-dir "$(vapoursynth get-plugin-dir)"
}
