# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson git-r3 python-single-r1

EGIT_SUBMODULES=( '-*' )

DESCRIPTION="Works based on L-SMASH project"
HOMEPAGE="https://github.com/HomeOfAviSynthPlusEvolution/L-SMASH-Works"
EGIT_REPO_URI="https://github.com/HomeOfAviSynthPlusEvolution/L-SMASH-Works.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	dev-libs/xxhash
	media-libs/l-smash
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP},legacy]
	media-video/ffmpeg
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}/VapourSynth"

DOCS=( "README.md" )

src_prepare() {
	local install_path="$(vapoursynth get-plugin-dir)"
	sed -i "s|join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')|'${install_path}'|" meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
