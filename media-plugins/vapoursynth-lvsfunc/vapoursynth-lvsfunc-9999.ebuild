# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit python-utils-r1 python-single-r1

DESCRIPTION="Light's Vapoursynth Functions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/lvsfunc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/lvsfunc.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/lvsfunc/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_USEDEP}]
	media-plugins/vapoursynth-fvsfunc
	media-plugins/vapoursynth-havsfunc
	media-plugins/vapoursynth-kagefunc
	media-plugins/vapoursynth-mvsfunc
	media-plugins/vapoursynth-nnedi3_rpow2
	media-plugins/vapoursynth-vstaambk
	media-plugins/vsutil
"
DEPEND="${RDEPEND}"

# FIXME:Optional dependencies
#     waifu2x-caffe
#     L-SMASH Source
#     d2vsource
#     FFMS2

DOCS=( "README.md" )


src_install(){
	python_domodule lvsfunc.py
}
