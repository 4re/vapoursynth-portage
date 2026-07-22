# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1 git-r3

DESCRIPTION="A plugin to load and apply 3D luts to a video"
HOMEPAGE="https://github.com/sekrit-twc/timecube"

EGIT_REPO_URI="https://github.com/sekrit-twc/timecube.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/r${PV}"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE=""
SLOT="0"
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_prepare() {
    default
    sed -i '/#include <string_view>/a #include <algorithm>' timecube/cube.cpp || die
}

src_install() {
	insinto "$(vapoursynth get-plugin-dir)"
	doins "vscube.so"
}
