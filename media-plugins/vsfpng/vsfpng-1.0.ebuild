# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit meson python-single-r1

DESCRIPTION="fpng for VapourSynth"
HOMEPAGE="https://github.com/Mikewando/vsfpng"
LICENSE="LGPL-2.1"
SLOT="0"

IUSE="lto tools"
RESTRICT="mirror"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Mikewando/vsfpng.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Mikewando/vsfpng/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

RDEPEND+="
	media-libs/vapoursynth:0/4
	media-video/ffmpeg
	tools? ( ${PYTHON_DEPS} )
"
DEPEND="${RDEPEND}
"

PATCHES=( "${FILESDIR}/${PN}-aarch-flags.patch" )

src_prepare() {
	default
	sed -i '1i#!/usr/bin/env python3' "examples/dump_frames.py" || die
}

src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	if use tools; then
		python_newscript "examples/dump_frames.py" "vspipe-dump-frames"
	fi
}
