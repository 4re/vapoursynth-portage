# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="Raw format video reader for VapourSynth"
HOMEPAGE="https://github.com/chikuzen/vsrawsource"

EGIT_REPO_URI="https://github.com/myrsloik/vsrawsource.git"
EGIT_COMMIT="9634f88ae58f672245bc7dc742337bca9bb809c9"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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
