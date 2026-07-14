# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 git-r3

DESCRIPTION="fpng for VapourSynth"
HOMEPAGE="https://github.com/Mikewando/vsfpng"
EGIT_REPO_URI="https://github.com/Mikewando/vsfpng.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_prepare() {
	default
	sed -i '1i#!/usr/bin/env python3' "python/vsfpng.py" || die
}

src_configure() {
	DISTUTILS_ARGS=(
		-Db_lto=$(usex lto true false)
	)
}
