# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 git-r3

DESCRIPTION="libplacebo-based debanding, scaling and color mapping plugin for VapourSynth"
HOMEPAGE="https://github.com/Lypheo/vs-placebo"
EGIT_REPO_URI="https://github.com/Lypheo/vs-placebo.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="lto dovi"
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/libplacebo-7.360.1
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
	dovi? (
		media-libs/libdovi
		>=media-plugins/vapoursynth-ffmpegsource-5.0
	)
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )

src_unpack() {
	default
	git-r3_src_unpack

	local libp2p_repo_uri="https://github.com/sekrit-twc/libp2p.git"
	local libp2p_commit="f50288b0c8db2cb14bb98fc25a5f056609d03652"
	local libp2p_dir="${S}/subprojects/libp2p-${libp2p_commit}"
	local libp2p_patch_dir="${S}/subprojects/packagefiles/libp2p-${libp2p_commit}"

	mkdir -p "${libp2p_dir%/*}" || die
	git-r3_fetch "${libp2p_repo_uri}" "${libp2p_commit}" || die
	git-r3_checkout "${libp2p_repo_uri}" "${libp2p_dir}" || die
	cp "${libp2p_patch_dir}/meson.build" "${libp2p_dir}" || die
	cp "${libp2p_patch_dir}/meson_options.txt" "${libp2p_dir}" || die
}

src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
