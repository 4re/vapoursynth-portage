# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit git-2

DESCRIPTION=""
HOMEPAGE="https://github.com/VFR-maniac/L-SMASH-Works"
EGIT_REPO_URI="https://github.com/VFR-maniac/L-SMASH-Works.git"

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
	./configure --prefix=/usr --libdir=/usr/lib64 --includedir=/usr/include --extra-cflags="${CFLAGS} -fPIC" --extra-ldflags="${LDFLAGS}" || die
}

src_compile() {
	cd VapourSynth
	emake || die
}

src_install() {
	exeinto /usr/lib/vapoursynth/
	mv VapourSynth/vslsmashsource.so.??? VapourSynth/vslsmashsource.so || die
	doexe VapourSynth/vslsmashsource.so || die
}
