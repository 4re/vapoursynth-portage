# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg-utils desktop

DESCRIPTION="VapourSynth Editor"
HOMEPAGE="https://github.com/YomikoR/VapourSynth-Editor"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/YomikoR/VapourSynth-Editor.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/YomikoR/VapourSynth-Editor/archive/refs/tags/r19-mod-${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
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
	dev-qt/qtnetwork:5
	dev-qt/qtwebsockets:5
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${P}-typo.patch" )

src_prepare() {
	rm -fr generated/* || die "Remove unused"
	default
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
	dobin   build/release-*/vsedit build/release-*/vsedit-job-server build/release-*/vsedit-job-server-watcher
	doicon  build/release-*/vsedit.ico build/release-*/vsedit.svg
	dodoc   build/release-*/CHANGELOG build/release-*/LICENSE build/release-*/README
	make_desktop_entry vsedit "VapourSynth Editor" vsedit Development "MimeType=text/x-vpy;\nTerminal=false\nStartupNotify=false"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
