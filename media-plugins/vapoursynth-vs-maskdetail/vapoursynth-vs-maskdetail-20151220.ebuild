# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1 git-r3

DESCRIPTION="A function to use invks/debilinear"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=171546"
EGIT_REPO_URI="https://github.com/MonoS/VS-MaskDetail.git"
EGIT_COMMIT="1f927c842820ec61583c9b87ba3c169b15e09c4c"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

src_prepare() {
	sed -i -e "s:get_core():core:" MaskDetail.py || die
	default
}

src_install(){
	python_domodule MaskDetail.py
}
