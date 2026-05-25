# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1

DESCRIPTION="VapourSynth port of RemoveGrain and Repair plugins from Avisynth"
HOMEPAGE="https://github.com/vapoursynth/vs-removegrain"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/vs-removegrain.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/vapoursynth/vs-removegrain/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_prepare() {
	default
	cp "${FILESDIR}/meson.build" "${S}"|| die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
