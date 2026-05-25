# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 git-r3

DESCRIPTION="Sample/frame accurate access to audio and video source plugin for VaporSynth"
HOMEPAGE="https://github.com/vapoursynth/bestsource"

EGIT_REPO_URI="https://github.com/vapoursynth/bestsource.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/R${PV}"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	dev-libs/jansson
	dev-libs/xxhash
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	>=media-video/ffmpeg-7.1
"
DEPEND="${RDEPEND}
"

src_configure() {
	DISTUTILS_ARGS=(
		-Db_lto=$(usex lto true false)
	)
}
