# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1

DESCRIPTION="A format-conversion plug-in for the Vapoursynth video processing engine"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166504 https://gitlab.com/EleonoreMizo/fmtconv"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/EleonoreMizo/fmtconv.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://gitlab.com/EleonoreMizo/fmtconv/-/archive/r31/fmtconv-r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"
IUSE=""

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
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
	econf --libdir="$(vapoursynth get-plugin-dir)"
}
