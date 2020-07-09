# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="Converts VFR video to CFR video through the use of Matroska Version 2 Timecodes"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-VFRToCFR"

EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-VFRToCFR"
EGIT_COMMIT="6c8cd2b13179e1861fcabe64dadb32b411bfeb69"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD-3"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

DOCS=( "README.rst" )


src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
