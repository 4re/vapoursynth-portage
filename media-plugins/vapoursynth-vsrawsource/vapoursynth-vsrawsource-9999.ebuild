# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs multilib

DESCRIPTION="Raw format video reader for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/vsrawsource"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/myrsloik/vsrawsource.git"
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/myrsloik/vsrawsource/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	if use debug ; then
		myconf="${myconf} --enable-debug"
	fi
	sed -i 's/STRIP="${CROSS}${STRIP}"/STRIP=""/' configure || die
	sed -i 's/"$CC" "$LD" "$STRIP"/"$CC" "$LD"/' configure || die
	sed -i -e "s:CC=\"gcc\":CC=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"gcc\":LD=\"$(tc-getCC)\":" configure || die
	./configure ${myconf} --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}

src_install() {
	exeinto /usr/$(get_libdir)/vapoursynth/
	doexe libvsrawsource.so
	dodoc format_list.txt readme.rst
}
