# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A format-conversion plug-in for the Vapoursynth video processing engine"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166504 https://gitlab.com/EleonoreMizo/fmtconv"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/EleonoreMizo/fmtconv.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/EleonoreMizo/fmtconv/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth:0/4
"
DEPEND="${RDEPEND}
"

HTML_DOCS=( "${WORKDIR}/${P}"/doc/. )

S="${WORKDIR}/${P}/build/unix"


src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
}
