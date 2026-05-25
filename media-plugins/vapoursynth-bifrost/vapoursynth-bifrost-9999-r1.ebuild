# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1

DESCRIPTION="Decrawler plugin for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-bifrost"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubhater/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="WTFPL-2"
SLOT="0"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( readme.rst )

src_prepare() {
	eapply_user

	find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" \) \
		-exec sed -i 's|vapoursynth/VS|VS|g;s|vapoursynth/VapourSynth|VapourSynth|g' {} +

	./autogen.sh
}

src_configure() {
	econf --libdir="$(vapoursynth get-plugin-dir)"
}
