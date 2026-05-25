# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1

DESCRIPTION="Histogram plugin for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-histogram"

inherit git-r3

EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-histogram.git"
EGIT_COMMIT="c15398b1ceb3c4debb63f29ab3d0fa1c84cb0436"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="$(vapoursynth get-plugin-dir)"
}
