# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit meson python-single-r1 git-r3

DESCRIPTION="An optimized pixelwise OpenCL implementation of the Non-local means denoising algorithm"
HOMEPAGE="https://github.com/Khanattila/KNLMeansCL"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Khanattila/KNLMeansCL.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Khanattila/KNLMeansCL/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="LGPL-3"
SLOT="0/1.1"
CARDS=( nvidia )
IUSE="lto ${CARDS[@]/#/video_cards_}"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP},legacy]
	virtual/opencl
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers
		dev-libs/opencl-icd-loader
		)
"
DEPEND="${RDEPEND}
	dev-util/opencl-headers
"

src_prepare() {
	default
	local install_path="$(vapoursynth get-plugin-dir)"

	sed -i "s|join_paths(get_option('prefix'), get_option('libdir'), 'vapoursynth')|'${install_path}'|" meson.build || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
