# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="Common image-processing filters for vapoursynth"
HOMEPAGE="https://github.com/chikuzen/GenericFilters"

EGIT_REPO_URI="https://github.com/myrsloik/GenericFilters.git"
EGIT_COMMIT="de02ff03101e67f004a4f46ba3266acad60379be"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="-noasm debug"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/src"

src_prepare() {
	sed -i 's/"$CC" "$LD" "$STRIP"/"$CC" "$LD"/' configure || die
	sed -i 's/STRIP="${CROSS}${STRIP}"/STRIP=""/' configure || die
	if use debug ; then
		myconf="${myconf} --enable-debug"
	fi
	if use noasm ; then
		myconf="${myconf} --disable-simd"
	fi
	sed -i -e "s:CC=\"gcc\":CC=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"gcc\":LD=\"$(tc-getCC)\":" configure || die
	chmod +x configure || die
}

src_configure() {
	./configure ${myconf} --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe libgenericfilters.so
	dodoc ../readme.rst
}
