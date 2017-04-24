# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Spatio-temporal limited median denoiser"
HOMEPAGE="https://github.com/dubhater/vapoursynth-degrainmedian"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}"


src_prepare() {
	eapply_user
	./autogen.sh
}


src_configure() {
	if use doc; then DOCS=( readme.rst ); fi
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}
