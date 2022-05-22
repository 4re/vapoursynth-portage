# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1 git-r3

DESCRIPTION="Mastroka ordered chapters automation script"
HOMEPAGE="https://github.com/OrangeChannel/ocsuite"

EGIT_REPO_URI="https://github.com/OrangeChannel/ocsuite.git"
EGIT_COMMIT="c20a1661be33c31a4fa071e1571eac04a2c7cf0c"
KEYWORDS="~amd64 ~x86"

LICENSE="Unlicense"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/acsuite
	media-video/mkvtoolnix
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )


src_install(){
	python_domodule ocsuite.py
}
