# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="IVTC assistant for VapourSynth, similar to Yatta"
HOMEPAGE="https://github.com/dubhater/Wobbly"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="ISC"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth
	dev-qt/qtwidgets
	media-plugins/vapoursynth-d2vsource
	media-plugins/vapoursynth-fieldhint
	media-plugins/vapoursynth-scxvid
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
