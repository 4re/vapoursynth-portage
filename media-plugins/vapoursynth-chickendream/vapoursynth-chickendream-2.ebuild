# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1

DESCRIPTION="A realistic film grain generator"
HOMEPAGE="https://gitlab.com/EleonoreMizo/chickendream"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://gitlab.com/EleonoreMizo/chickendream.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://gitlab.com/EleonoreMizo/chickendream/-/archive/r${PV}/chickendream-r${PV}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="WTFPL-2"
SLOT="0"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/build/unix"

src_prepare() {
	default
	chmod +x autogen.sh || die
	./autogen.sh || die
}

src_configure() {
	econf --libdir="$(vapoursynth get-plugin-dir)"
}

src_compile() {
	emake
}
