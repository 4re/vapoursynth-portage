# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Works based on L-SMASH project"
HOMEPAGE="https://github.com/HolyWu/L-SMASH-Works"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HolyWu/L-SMASH-Works.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/HolyWu/L-SMASH-Works/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND+="
	media-video/ffmpeg
	media-libs/l-smash
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/${P}/VapourSynth"
