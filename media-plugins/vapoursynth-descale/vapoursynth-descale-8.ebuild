# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1

DESCRIPTION="VapourSynth plugin to undo upscaling"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="WTFPL-2"
SLOT="0"
IUSE="lto"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )

src_prepare() {
	default
	sed -i "/cc = meson.get_compiler('c')/a py = import('python').find_installation(pure: false)" meson.build || die
	sed -i "s|install_dir: installdir$|install_dir: py.get_install_dir() / 'vapoursynth/plugins'|" meson.build || die

	find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" \) \
		-exec sed -i 's|vapoursynth/VS|VS|g;s|vapoursynth/VapourSynth|VapourSynth|g' {} +
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_domodule descale.py
}
