# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils git-r3

DESCRIPTION="simple blurring/sharpening filter for vaporsynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=173328"

EGIT_REPO_URI="https://github.com/IFeelBloated/minsrp.git"
EGIT_COMMIT="8d0ee6ef7006bb554cc33f0fc9e0f42e2d18fc8d"
KEYWORDS="~amd64 ~x86"

LICENSE=""
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/build/unix"

src_configure() {
	autotools-utils_src_configure --libdir="/usr/$(get_libdir)/vapoursynth/"
}

src_install() {
	use doc && DOCS=( "${WORKDIR}/${P}/README.md" )
	autotools-utils_src_install
}
