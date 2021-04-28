# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="simple blurring/sharpening filter for vaporsynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=173328"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/minsrp.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/IFeelBloated/minsrp/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

RESTRICT="mirror"
LICENSE=""
SLOT="0"
IUSE="doc"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/build/unix"

PATCHES=( "${FILESDIR}/${P}-memalign.patch"
          "${FILESDIR}/${P}-missingInclude.patch" )

src_prepare() {
	cd "${WORKDIR}/${P}"
	eapply_user
	default
	cd ${S}
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}

src_install() {
	use doc && DOCS=( "${WORKDIR}/${P}/README.md" )
	default
}
