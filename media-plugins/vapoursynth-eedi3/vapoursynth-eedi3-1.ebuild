# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="An intra-frame deinterlacer"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3"

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
IUSE="opencl"

RDEPEND+="
	media-libs/vapoursynth
	opencl? ( virtual/opencl )
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

PATCHES=( "${FILESDIR}/${P}-autotools.diff" )

src_prepare() {
	eapply ${PATCHES}
	eapply_user
	./autogen.sh
}

src_configure() {
	econf $(use_enable opencl) --libdir="/usr/$(get_libdir)/vapoursynth/"
}
