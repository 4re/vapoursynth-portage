# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Builds an edge map using canny edge detection"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TCanny"

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
	opencl? (
		dev-libs/boost
		virtual/opencl
		)
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply "${FILESDIR}/${P}-fix_disable-opencl.patch"
	eapply_user
	./autogen.sh
}

src_configure() {
	econf $(use_enable opencl) --libdir="/usr/$(get_libdir)/vapoursynth/"
}
