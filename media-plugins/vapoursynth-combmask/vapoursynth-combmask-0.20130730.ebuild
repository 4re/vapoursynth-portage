# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib git-r3

DESCRIPTION="CombMask plugin for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/CombMask"
EGIT_REPO_URI="https://github.com/chikuzen/CombMask.git"
EGIT_COMMIT="2ec6679270d0136ec285d7cfc79c7c02af88caa1"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
