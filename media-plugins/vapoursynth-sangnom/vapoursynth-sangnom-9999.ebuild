# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="A rewrite version of AVISynth SangNom2"
HOMEPAGE="https://bitbucket.org/James1201/vapoursynth-sangnom"

if [[ ${PV} == *9999* ]]; then
	inherit mercurial
	EHG_REPO_URI="https://bitbucket.org/James1201/${PN}"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://bitbucket.org/James1201/${PN}/get/r${PV}.tar.bz2 -> ${PN}-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_prepare() {
	eapply_user
	fperms +x autogen.sh
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
