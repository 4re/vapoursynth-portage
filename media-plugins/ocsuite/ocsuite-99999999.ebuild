# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1

DESCRIPTION="Mastroka ordered chapters automation script"
HOMEPAGE="https://github.com/OrangeChannel/ocsuite"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/OrangeChannel/ocsuite.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/OrangeChannel/ocsuite/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

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
