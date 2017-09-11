# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="A plugin which adjust the clip via bezier curve"
HOMEPAGE="https://github.com/kewenyu/VapourSynth-BezierCurve"
GHRM="kewenyu"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${GHRM}/${PN}"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/${GHRM}/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	dev-util/meson
	virtual/pkgconfig
"
