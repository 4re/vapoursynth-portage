# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="VapourSynth Zig Image Process"
HOMEPAGE="https://github.com/dnjulek/vapoursynth-zip"

declare -g -r -A ZBS_DEPENDENCIES=(
	[vapoursynth-4.0.0-jLYMQ799AgCA8sL5lgewK9acIrAKjs-ByT2pdKI5dHq2.tar.gz]='https://github.com/dnjulek/vapoursynth-zig/archive/8e93fe3433bb977135f81040bb59d964c58a1cb9.tar.gz'
	[zigimg-0.1.0-8_eo2jNrFQD4mu3EAUkfQRmCkyfprdIXc8JQ6uyxhjSQ.tar.gz]='https://github.com/coisos/zigimg/archive/362cdd6bce109f7bc674be134cddd378f52da5d4.tar.gz'
)

ZIG_SLOT="0.15"

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

src_install() {
	zig_src_install --prefix-lib-dir "$(get_libdir)/vapoursynth"
}
