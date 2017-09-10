# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A 3-way low-pass filter, which can completely remove high-frequency noise while minimizing blending artifacts"
HOMEPAGE="https://github.com/Hinterwaeldlers/vapoursynth-hqdn3d"

inherit git-r3
EGIT_REPO_URI="https://github.com/Hinterwaeldlers/${PN}.git"
EGIT_COMMIT="c36c1b8609f78f75a1e8eb15e4919cb8ad0dfb94"
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
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
