# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit git-2 eutils

DESCRIPTION="VapourSynth Editor"
HOMEPAGE="https://bitbucket.org/mystery_keeper/vapoursynth-editor"
EGIT_REPO_URI="https://bitbucket.org/mystery_keeper/vapoursynth-editor.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
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
	cd "${S}"
	epatch "${FILESDIR}/includes.patch"
}

src_configure() {
	cd pro
		/usr/lib64/qt5/bin/qmake || die "Qmake pro"
}

src_compile() {
	cd pro
	emake || die "Make"
}

src_install() {
	dobin   build/bin/vsedit || die
	doicon  build/bin/vsedit.ico build/bin/vsedit.svg || die
	dodoc   build/bin/CHANGELOG build/bin/LICENSE build/bin/README || die
}
