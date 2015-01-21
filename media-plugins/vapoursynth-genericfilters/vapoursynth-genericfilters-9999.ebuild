# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Common image-processing filters for vapoursynth"
HOMEPAGE="https://github.com/chikuzen/GenericFilters"
EGIT_REPO_URI="https://github.com/myrsloik/GenericFilters.git"
#EGIT_REPO_URI="https://github.com/chikuzen/GenericFilters.git"

inherit git-2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-noasm debug"
RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
        if use debug ; then
                myconf="${myconf} --enable-debug"
	        sed -i 's/"$CC" "$LD" "$STRIP"/"$CC" "$LD"/' src/configure || die
        fi
        if use noasm ; then
                myconf="${myconf} --disable-simd"
	fi
	cd src
	chmod +x configure
	./configure ${myconf} --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_compile() {
	cd src
	emake || die
}

src_install() {
	cd src/
        exeinto /usr/lib/vapoursynth/
        doexe libgenericfilters.so
}
