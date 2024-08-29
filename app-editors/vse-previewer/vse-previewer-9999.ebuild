# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg-utils desktop

DESCRIPTION="VapourSynth standalone previewer"
HOMEPAGE="https://github.com/YomikoR/VapourSynth-Editor"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/YomikoR/VapourSynth-Editor.git"
	EGIT_BRANCH="vse-previewer"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/YomikoR/VapourSynth-Editor/archive/refs/tags/VSE-Previewer-R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	media-libs/vapoursynth
	dev-qt/qtbase[widgets]
	dev-qt/qtmultimedia:6
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	cd pro
	eqmake6
}

src_compile() {
	cd pro
	default
}

src_install() {
	dobin   build/release-*/vse-previewer
	dodoc   build/release-*/CHANGELOG build/release-*/LICENSE build/release-*/README
}
