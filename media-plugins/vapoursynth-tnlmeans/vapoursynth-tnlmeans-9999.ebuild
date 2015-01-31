# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit git-2

DESCRIPTION="VapourSynth port of TNLMeans"
HOMEPAGE="https://github.com/VFR-maniac/VS-TNLMeans"
EGIT_REPO_URI="https://github.com/VFR-maniac/VS-TNLMeans.git"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

RDEPEND+="
    media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
    chmod +x configure || die
    ./configure --extra-cxxflags="${CXXFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	mv vstnlmeans.so.?? vstnlmeans.so || die
	doexe vstnlmeans.so || die
    dodoc README LICENSE
}
