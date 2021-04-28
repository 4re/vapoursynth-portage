# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Scene change detection plugin for VapourSynth, using XviD"
HOMEPAGE="https://github.com/dubhater/vapoursynth-scxvid"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	media-libs/xvid
"
DEPEND="${RDEPEND}
"

DOCS=( readme.rst )

src_prepare() {
	eapply_user
	default
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
