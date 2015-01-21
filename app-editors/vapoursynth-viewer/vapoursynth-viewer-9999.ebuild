# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit git-2 qt4-r2

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/dubhater/vapoursynth-viewer.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
        media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"
src_unpack() {
	git-2_src_unpack
}

src_configure() {
	sed -i "s/PKGCONFIG += vapoursynth-script//g" vsviewer.pro
	eqmake4 vsviewer.pro
	sed -i  -e 's/-lpthread/-lpthread -lvapoursynth-script/g' \
		-e 's~-I/usr/include/qt4/QtGui~-I/usr/include/qt4/QtGui -I/usr/include/vapoursynth~g' Makefile || die
}

src_install() {
        exeinto /usr/bin
        doexe vsviewer
}
