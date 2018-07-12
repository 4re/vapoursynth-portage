# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson flag-o-matic

DESCRIPTION="Spatial derainbow filter"
HOMEPAGE="https://github.com/dubhater/vapoursynth-smoothuv"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	>=dev-util/meson-0.46
"
src_configure() {
	append-cxxflags $(test-flags-CXX -fpeel-loops)
	meson_src_configure  --libdir="/usr/$(get_libdir)/vapoursynth/"
}
