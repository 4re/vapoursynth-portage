# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils eutils

DESCRIPTION="Cross-platform D2V creator"
HOMEPAGE="https://github.com/dubhater/D2VWitch"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC LGPL-2.1"
SLOT="0"
IUSE=""

RDEPEND+="
	>=virtual/ffmpeg-9
"
DEPEND="${RDEPEND}
	dev-qt/qtwidgets
	media-libs/vapoursynth
"
