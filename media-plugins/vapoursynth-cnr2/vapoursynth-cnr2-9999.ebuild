# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit toolchain-funcs multilib autotools-utils

DESCRIPTION="Chroma noise reducer"
HOMEPAGE="https://github.com/dubhater/vapoursynth-cnr2"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-cnr2.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/vapoursynth-cnr2/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	autotools-utils_src_configure --libdir="/usr/$(get_libdir)/vapoursynth/"
}

src_install() {
	use doc && DOCS=( readme.rst )
	autotools-utils_src_install
}
