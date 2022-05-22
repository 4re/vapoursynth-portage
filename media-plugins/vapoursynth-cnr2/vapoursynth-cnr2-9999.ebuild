# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Chroma noise reducer"
HOMEPAGE="https://github.com/dubhater/vapoursynth-cnr2"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-cnr2.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/vapoursynth-cnr2/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

PATCHES=( "${FILESDIR}/${P}-make.patch" )

src_prepare() {
	eapply_user
	default
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}

src_install() {
	use doc && DOCS=( readme.rst )
	default
}
