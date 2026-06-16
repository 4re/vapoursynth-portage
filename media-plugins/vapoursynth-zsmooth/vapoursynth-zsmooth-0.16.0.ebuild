# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=no

DESCRIPTION="Video smoothing functions for Vapoursynth"
HOMEPAGE="https://github.com/adworacz/zsmooth"

declare -g -r -A ZBS_DEPENDENCIES=(
	[vapoursynth-4.0.0-jLYMQw95AgBWLJymsYybHIFxNu7d6shoYn8y8WZfH8T3.tar.gz]='https://github.com/dnjulek/vapoursynth-zig/archive/a94152c87e4242a582ec5f30f4d4e890c14e2233.tar.gz'
	[fftw-3.3.11-2-EjV1I17WAgD0Lnb_BKT51TNd_56-eY4NBOPHO2IH_WHZ.tar.gz]='https://github.com/adworacz/fftw/archive/579b516e6b39a2a96200d248fc3c96d1ad7d9841.tar.gz'
	[fftw-3.3.11.tar.gz]='https://www.fftw.org/fftw-3.3.11.tar.gz'
)

ZIG_SLOT="0.16"

inherit distutils-r1 zig

SRC_URI="
	https://github.com/adworacz/zsmooth/archive/${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"

DOCS=( "README.md" )

S="${WORKDIR}/zsmooth-${PV}"

src_configure() {
	local my_zbs_args=(
		--prefix-lib-dir ""
	)
	zig_src_configure
}

src_install() {
	zig_src_install --prefix "$(vapoursynth get-plugin-dir)"
}
