# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="A collection of general purpose Vapoursynth functions to be reused in modules and scripts"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vsutil"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vsutil.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vsutil/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule vsutil
}
