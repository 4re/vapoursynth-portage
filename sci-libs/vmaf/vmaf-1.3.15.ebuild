# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="Perceptual video quality assessment based on multi-method fusion."
HOMEPAGE="https://github.com/Netflix/vmaf/"

EGIT_REPO_URI="https://github.com/Netflix/vmaf.git"
EGIT_COMMIT="e558029b40125edebfd837e7b2ac1b0ff099f552"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/yasm"

S="${WORKDIR}/${P}/libvmaf"
