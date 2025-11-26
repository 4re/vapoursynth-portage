# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
PYTHON_REQ_USE="threads(+)"

inherit meson python-single-r1

DESCRIPTION="VapourSynth is an library for video manipulation."
HOMEPAGE="http://www.vapoursynth.com/"
LICENSE="LGPL-2.1 OFL-1.1"
SLOT="0/4"

IUSE="lto +vspipe -debug -guard -static-libs cpu_flags_x86_sse2"
RESTRICT="mirror"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/vapoursynth.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/vapoursynth/vapoursynth/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND+="${PYTHON_DEPS}
	>=media-libs/zimg-3.0.5
"
DEPEND="${RDEPEND}
	dev-python/cython
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
		-Denable_python_module=true
		-Denable_vsscript=true
		$(meson_use debug)
		-Db_ndebug=$(usex debug false true)
		-Ddefault_library=$(usex static-libs static shared)
		$(meson_use guard enable_guard_pattern)
		$(meson_use vspipe enable_vspipe)
		$(meson_use cpu_flags_x86_sse2 enable_x86_asm)
	)
	meson_src_configure
}
