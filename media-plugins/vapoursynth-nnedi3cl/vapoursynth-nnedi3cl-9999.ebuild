# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="VapourSynth port of NNEDI3 utilizing OpenCL"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL"
GHRM="HomeOfVapourSynthEvolution"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${GHRM}/${PN}"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/${GHRM}/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth
	dev-libs/boost
	virtual/opencl"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
