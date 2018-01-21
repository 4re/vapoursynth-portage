# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A filter for converting high dynamic range (HDR) video to standard dynamic range (SDR)"
HOMEPAGE="https://github.com/ifb/vapoursynth-tonemap"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ifb/vapoursynth-tonemap.git"
	KEYWORDS=""
	KEYWORDS="~amd64 ~x86"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/ifb/vapoursynth-tonemap/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND+="media-libs/vapoursynth"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
