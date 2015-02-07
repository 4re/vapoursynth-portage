# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="VapourSynth Editor"
HOMEPAGE="https://bitbucket.org/mystery_keeper/vapoursynth-editor"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/mystery_keeper/${PN}.git"
	#EGIT_COMMIT="5499b832d35e5159a6554494e1bd1ea300be44b5"
else
	inherit vcs-snapshot
	SRC_URI="https://bitbucket.org/mystery_keeper/${PN}/get/r${PV}.tar.bz2 -> ${PN}-${PV}.tar.bz2"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/vapoursynth
	>=dev-qt/qtcore-5.3.0
	>=dev-qt/qtgui-5.3.0
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	rm -fr generated/* || die "Remove unused"
}

src_configure() {
	cd pro
	eqmake5
}

src_compile() {
	cd pro
	emake || die "Make"
}

src_install() {
	# This is ugly
	dobin   build/release-*/vsedit || die
	doicon  build/release-*/vsedit.ico build/release-*/vsedit.svg || die
	dodoc   build/release-*/CHANGELOG build/release-*/LICENSE build/release-*/README || die
}
