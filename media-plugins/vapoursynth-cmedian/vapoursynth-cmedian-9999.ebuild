# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Implements the constant time median filter algorithm for Vapoursynth"
HOMEPAGE="https://bitbucket.org/James1201/vapoursynth-cmedian"

if [[ ${PV} == *9999* ]]; then
	inherit mercurial
	EHG_REPO_URI="https://bitbucket.org/James1201/vapoursynth-cmedian"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://bitbucket.org/James1201/vapoursynth-cmedian/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )


src_prepare() {
	eapply_user
	chmod +x autogen.sh
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
