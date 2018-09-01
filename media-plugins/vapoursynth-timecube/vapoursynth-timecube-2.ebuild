# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A plugin to load and apply 3D luts to a video"
HOMEPAGE="https://github.com/sekrit-twc/timecube"
EGIT_REPO_URI="https://github.com/sekrit-twc/timecube.git"
EGIT_COMMIT="55c91c0a4121f91aeae9e30fec873ce5c8b64bde"

KEYWORDS="~amd64 ~x86"

LICENSE=""
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_install() {
	insinto "/usr/$(get_libdir)/vapoursynth/"
	doins "vscube.so"
}
