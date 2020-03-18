# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 )

inherit python-single-r1 git-r3

DESCRIPTION="Mastroka ordered chapters automation script"
HOMEPAGE="https://github.com/OrangeChannel/ocsuite"

EGIT_REPO_URI="https://github.com/OrangeChannel/ocsuite.git"
EGIT_COMMIT="d24a0fe5a3b5727be92d877fa5b97d60126128ec"
KEYWORDS="~amd64 ~x86"

LICENSE=""
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
