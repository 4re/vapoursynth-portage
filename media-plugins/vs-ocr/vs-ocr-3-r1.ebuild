# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1

DESCRIPTION="OCR plugin for VapourSynth"
HOMEPAGE="https://github.com/vapoursynth/vs-ocr"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vapoursynth/vs-ocr.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/vapoursynth/vs-ocr/archive/R${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
	app-text/tesseract
"
DEPEND="${RDEPEND}
"

src_prepare() {
	default
	local install_path="$(vapoursynth get-plugin-dir)"

	sed -i "s|join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')|'${install_path}'|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
