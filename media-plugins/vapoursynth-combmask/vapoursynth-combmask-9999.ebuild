# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib

DESCRIPTION="CombMask plugin for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/CombMask"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chikuzen/CombMask.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/chikuzen/CombMask/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/vapoursynth/src"

src_configure() {
	chmod +x configure
	./configure \
		--install="${ED}/usr/$(get_libdir)/vapoursynth/" \
		--extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_install() {
	emake install
	dodoc ../readme.rst ../LICENSE.LGPLv2.1
}
