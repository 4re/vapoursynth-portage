# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Works based on L-SMASH project"
HOMEPAGE="https://github.com/VFR-maniac/L-SMASH-Works"

EGIT_REPO_URI="https://github.com/VFR-maniac/L-SMASH-Works.git"
EGIT_COMMIT="03117ec6d137fcbe22f922040cc47f59f6e419f9"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="-debug"
SLOT="0"

RDEPEND+="
	media-video/ffmpeg
	media-libs/l-smash
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/${P}/VapourSynth"

src_prepare() {
	eapply_user
	sed -i -e "s:CC=\"gcc\":CC=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"gcc\":LD=\"$(tc-getCC)\":" configure || die
}

src_configure() {
	./configure --prefix="${ROOT}/usr" --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}
