# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="vctrans a plugin for transitions"
HOMEPAGE="http://www.avisynth.nl/users/vcmohan/vctrans/vctrans.html http://forum.doom9.org/showthread.php?t=172594"
SRC_URI="https://www.dropbox.com/s/wvpu0qjnzotxtfj/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"
