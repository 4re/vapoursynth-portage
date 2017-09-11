# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="A plugin which adjust the clip via bezier curve"
HOMEPAGE="https://github.com/kewenyu/VapourSynth-BezierCurve"
GHRM="kewenyu"


EGIT_REPO_URI="https://github.com/${GHRM}/${PN}"
EGIT_COMMIT="eadfc1372670b989e56845e6694b7be76fedf02b"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	dev-util/meson
	virtual/pkgconfig
"
