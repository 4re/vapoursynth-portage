# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="VapourSynth port of NNEDI3 utilizing OpenCL"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
	dev-libs/boost
	virtual/opencl
	dev-libs/opencl-icd-loader
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )


src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
