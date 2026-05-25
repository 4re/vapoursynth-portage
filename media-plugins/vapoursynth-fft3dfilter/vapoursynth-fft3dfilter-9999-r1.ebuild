# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1

DESCRIPTION="VapourSynth port of FFT3DFilter"
HOMEPAGE="https://github.com/myrsloik/VapourSynth-FFT3DFilter"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/VapourSynth-FFT3DFilter"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/myrsloik/VapourSynth-FFT3DFilter/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
	sci-libs/fftw:3.0[threads]
"
DEPEND="${RDEPEND}
"

DOCS=( "doc/fft3dfilter.md" )

src_prepare() {
	default
	local install_path="$(vapoursynth get-plugin-dir)"

	sed -i "s|install_dir : join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')|install_dir : '${install_path}'|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
