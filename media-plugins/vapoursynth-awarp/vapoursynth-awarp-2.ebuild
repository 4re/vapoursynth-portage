# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="AWarp filter for VapourSynth"
HOMEPAGE="https://github.com/HolyWu/VapourSynth-AWarp"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HolyWu/VapourSynth-AWarp.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HolyWu/VapourSynth-AWarp/archive/r${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth:0/4
"
DEPEND="${RDEPEND}
"

src_configure() {
	local emesonargs=(
		--libdir="${EPREFIX}/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
