# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1

DESCRIPTION="Light's Vapoursynth Functions"
HOMEPAGE="https://github.com/Jaded-Encoding-Thaumaturgy/lvsfunc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Jaded-Encoding-Thaumaturgy/lvsfunc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Jaded-Encoding-Thaumaturgy/lvsfunc/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="deint dvd fixedges mpls"

# Missing: vsdehalo, vsdeinterlace
RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-havsfunc
	media-plugins/vapoursynth-kagefunc
	media-plugins/vapoursynth-akarin
	media-plugins/vapoursynth-bm3d
	media-plugins/vapoursynth-descale
	media-plugins/vapoursynth-eedi3
	media-plugins/vapoursynth-fillborders
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-kagefunc
	media-plugins/vapoursynth-l-smash-works
	media-plugins/vapoursynth-nnedi3cl
	media-plugins/vapoursynth-remapframes
	media-plugins/vapoursynth-rgsf
	media-plugins/vapoursynth-scxvid
	media-plugins/vapoursynth-tdeintmod
	media-plugins/vapoursynth-tivtc
	media-plugins/vapoursynth-znedi3
	media-plugins/vs-aa
	media-plugins/vs-denoise
	media-plugins/vs-exprtools
	media-plugins/vs-masktools
	media-plugins/vs-kernels
	media-plugins/vs-placebo
	media-plugins/vs-tools
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )


src_install(){
	python_domodule lvsfunc
}
