# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg desktop

DESCRIPTION="VapourSynth Editor"
HOMEPAGE="https://github.com/YomikoR/VapourSynth-Editor"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/YomikoR/VapourSynth-Editor.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/YomikoR/VapourSynth-Editor/archive/refs/tags/R19-mod-${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""
RESTRICT="mirror"

RDEPEND="
	media-libs/vapoursynth
	dev-qt/qtbase[concurrent,gui,network,widgets]
	dev-qt/qtwebsockets
"
DEPEND="${RDEPEND}
"

src_configure() {
	cd "${S}/pro" || die
	eqmake6 pro.pro INCLUDEPATH+="$(vapoursynth get-include)"
}

src_compile() {
	emake -C "${S}/pro"
}

src_install() {
	dobin build/release-*/vsedit
	dobin build/release-*/vsedit-previewer
	dobin build/release-*/vsedit-job-server
	dobin build/release-*/vsedit-job-server-watcher
	dobin build/release-*/vsedit-encode
	doicon build/release-*/vsedit.ico
	doicon -s scalable build/release-*/vsedit.svg
	make_desktop_entry vsedit "VapourSynth Editor" "vsedit" "Development" "MimeType=text/x-vpy;\nTerminal=false\nStartupNotify=false"
	einstalldocs
}
