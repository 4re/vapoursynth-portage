# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit toolchain-funcs multilib autotools-utils

DESCRIPTION="A format-conversion plug-in for the Vapoursynth video processing engine"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166504"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EleonoreMizo/fmtconv.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/EleonoreMizo/fmtconv/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	use doc && HTML_DOCS=("${WORKDIR}/${P}/doc/")
	autotools-utils_src_install
}
