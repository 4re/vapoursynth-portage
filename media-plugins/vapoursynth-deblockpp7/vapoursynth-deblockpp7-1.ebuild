# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="TTempSmooth is a motion adaptive temporal smoothing filter"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DeblockPP7"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	chmod +x autogen.sh
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
