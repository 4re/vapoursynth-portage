# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="C++ wrapper for VSAPI to help you sketch your filter in the fastest possible way"
HOMEPAGE="https://github.com/IFeelBloated/vsFilterScript"

EGIT_REPO_URI="https://github.com/IFeelBloated/vsFilterScript.git"
EGIT_COMMIT="54fe3eda29277e612c35c86e8977c9b7922f736c"
KEYWORDS="~x86 ~amd64"

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
