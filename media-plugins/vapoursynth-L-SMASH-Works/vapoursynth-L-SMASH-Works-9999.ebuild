# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit git-2

DESCRIPTION=""
HOMEPAGE="https://github.com/VFR-maniac/L-SMASH-Works"
EGIT_REPO_URI="https://github.com/VFR-maniac/L-SMASH-Works.git"
EGIT_COMMIT="fd6528f780db1d632b5f8108ff7e4a716e650882"
LICENSE=""
KEYWORDS="~amd64 ~x86"
IUSE="-debug"
SLOT="0"

RDEPEND+="media-libs/l-smash
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	cd VapourSynth
	./configure --extra-cflags="${CFLAGS} -fPIC" --extra-ldflags="${LDFLAGS}" || die
}

src_compile() {
	cd VapourSynth
	emake
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	mv VapourSynth/vslsmashsource.so.??? VapourSynth/vslsmashsource.so || die
	doexe VapourSynth/vslsmashsource.so
}
