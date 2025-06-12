# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="VapourSynth Zig Image Process"
HOMEPAGE="https://github.com/dnjulek/vapoursynth-zip"

declare -g -r -A ZBS_DEPENDENCIES=(
	[vapoursynth-4.0.0-jLYMQwSJAgAK5i82AM1q02Is6sTRB_n4LuSk_U4h2har.tar.gz]='https://github.com/dnjulek/vapoursynth-zig/archive/b41f2ae15d895def65d30804c25e9b033899af71.tar.gz'
	[zigimg-0.1.0-KQznM1DpEQDNy_LQY61CLTIpC2phVjxmvXasAvjY-zc9.tar.gz]='https://github.com/coisos/zigimg/archive/466c86ee48f372a2b863af2a2c22c6a818e98242.tar.gz'
)

ZIG_SLOT="0.14"

inherit zig

SRC_URI="
	https://github.com/dnjulek/${PN}/archive/R${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

S="${WORKDIR}/${PN}-R${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/vapoursynth
"
DOCS=( "README.md" )
