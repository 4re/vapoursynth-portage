# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils qmake-utils xdg-utils

DESCRIPTION="VapourSynth Editor"
HOMEPAGE="https://bitbucket.org/mystery_keeper/vapoursynth-editor"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/mystery_keeper/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://bitbucket.org/mystery_keeper/${PN}/get/r${PV}.tar.bz2 -> ${PN}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	media-libs/vapoursynth
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtwebsockets:5
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	rm -fr generated/* || die "Remove unused"
	eapply_user
}

src_configure() {
	cd pro
	eqmake5
}

src_compile() {
	cd pro
	emake
}

src_install() {
	# This is ugly
	dobin   build/release-*/vsedit
	doicon  build/release-*/vsedit.ico build/release-*/vsedit.svg
	dodoc   build/release-*/CHANGELOG build/release-*/LICENSE build/release-*/README
	make_desktop_entry vsedit "VapourSynth Editor" vsedit Development "MimeType=text/x-vpy;\nTerminal=false\nStartupNotify=false"
}
