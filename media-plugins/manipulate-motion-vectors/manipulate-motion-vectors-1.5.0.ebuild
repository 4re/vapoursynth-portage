# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

DESCRIPTION="A vapoursynth plugin to do potentially useful things with motion vectors that have already been generated"
HOMEPAGE="https://github.com/Mikewando/manipulate-motion-vectors"

declare -g -r -A ZBS_DEPENDENCIES=(
	[vapoursynth-4.0.0-jLYMQ799AgCA8sL5lgewK9acIrAKjs-ByT2pdKI5dHq2.tar.gz]='https://github.com/dnjulek/vapoursynth-zig/archive/8e93fe3433bb977135f81040bb59d964c58a1cb9.tar.gz'
)

ZIG_SLOT="0.16"

inherit zig python-single-r1

SRC_URI="
	https://github.com/Mikewando/manipulate-motion-vectors/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"

DOCS=( "README.md" )

pkg_setup() {
	python-single-r1_pkg_setup
	zig-utils_setup
}

src_prepare() {
	# Get rid of set_version
	sed -i '/\.set_version[[:space:]]*=.*\.{/,/},/d' build.zig.zon || die
	sed -i \
		-e '/const set_version = @import/d' \
		-e '/VersionSetterStep/d' \
		-e 's|const current_version.*= set_version.*|const current_version: []const u8 = "'"${PV}"'";|' \
		build.zig || die
	zig_src_prepare
}

src_install() {
	zig_src_install --prefix "$(vapoursynth get-plugin-dir)"
}
