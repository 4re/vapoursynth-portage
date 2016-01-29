# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils eutils

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
"
DEPEND="${RDEPEND}
"
