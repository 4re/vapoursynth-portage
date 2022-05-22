# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A plugin for special effects"
HOMEPAGE="http://www.avisynth.nl/users/vcmohan/vfx/vfx.html"
SRC_URI="https://www.dropbox.com/s/f77wegxrqcyizbz/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"
