# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit mercurial

DESCRIPTION="Implements the constant time median filter algorithm for Vapoursynth"
HOMEPAGE="https://bitbucket.org/James1201/vapoursynth-cmedian"

EHG_REPO_URI="https://bitbucket.org/James1201/vapoursynth-cmedian"
EHG_REVISION="46063df02b428978de661363ab7e927d3fc70f87"
KEYWORDS="~amd64 ~x86"

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
