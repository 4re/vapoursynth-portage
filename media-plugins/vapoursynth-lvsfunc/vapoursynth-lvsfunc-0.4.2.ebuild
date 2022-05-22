# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

inherit python-single-r1

DESCRIPTION="Light's Vapoursynth Functions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/lvsfunc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/lvsfunc.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/lvsfunc/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="deint dvd fixedges mpls"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	deint? ( media-plugins/vapoursynth-combmask )
	dvd? ( media-plugins/vapoursynth-d2vsource )
	fixedges? ( media-plugins/vapoursynth-continuityfixer )
	mpls? ( media-plugins/vapoursynth-readmpls )
	media-plugins/vapoursynth-fvsfunc
	media-plugins/vapoursynth-havsfunc
	media-plugins/vapoursynth-kagefunc
	media-plugins/vapoursynth-mvsfunc
	media-plugins/vapoursynth-nnedi3_rpow2
	media-plugins/vapoursynth-vstaambk
	media-plugins/vsutil
	dev-python/toolz
	dev-python/rich
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )


src_install(){
	python_domodule lvsfunc
}
