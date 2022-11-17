# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-single-r1

DESCRIPTION="Parse and extract binary data from dvd files"
HOMEPAGE="https://github.com/Ichunjo/pyparsedvd"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Ichunjo/pyparsedvd.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Ichunjo/pyparsedvd/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+=""
DEPEND="${RDEPEND}"

DOCS=( "README.md" )


src_install(){
	python_domodule pyparsedvd
}
