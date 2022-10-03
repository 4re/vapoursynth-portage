# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A 3-way low-pass filter, which can completely remove high-frequency noise while minimizing blending artifacts"
HOMEPAGE="https://github.com/Hinterwaeldlers/vapoursynth-hqdn3d"

inherit git-r3
EGIT_REPO_URI="https://github.com/Hinterwaeldlers/${PN}.git"
EGIT_COMMIT="eb820cb23f7dc47eb67ea95def8a09ab69251d30"
KEYWORDS="~amd64 ~x86"

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
	econf --libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
}
