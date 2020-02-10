# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A plugin to load and apply 3D luts to a video"
HOMEPAGE="https://github.com/sekrit-twc/timecube"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sekrit-twc/timecube.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/sekrit-twc/timecube/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
