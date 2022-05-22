# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A plugin to load and apply 3D luts to a video"
HOMEPAGE="https://github.com/sekrit-twc/timecube"

EGIT_REPO_URI="https://github.com/sekrit-twc/timecube.git"
EGIT_COMMIT="22acabcf0d095fef5ac14526bed9b59db68ea38a"
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
