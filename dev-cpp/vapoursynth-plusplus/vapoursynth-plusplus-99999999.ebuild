# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="C++ wrapper for VSAPI to help you sketch your filter in the fastest possible way"
HOMEPAGE="https://github.com/IFeelBloated/vsFilterScript"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/vsFilterScript"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/IFeelBloated/vsFilterScript/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE=""
SLOT="0"
IUSE="examples lto plugin"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_configure() {
	local emesonargs=(
		-Dbuild_examples=$(usex plugin true false)
		-Dinstall_examples=$(usex examples true false)
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
