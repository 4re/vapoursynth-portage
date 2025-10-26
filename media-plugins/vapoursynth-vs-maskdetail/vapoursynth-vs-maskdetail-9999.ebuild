# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit python-single-r1

DESCRIPTION="A function to use invks/debilinear"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=171546"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MonoS/VS-MaskDetail.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/MonoS/VS-MaskDetail/archive/V${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi


LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-descale
	media-plugins/vapoursynth-fmtconv
	media-plugins/vs-removegrain
"
DEPEND="${RDEPEND}
"

src_install(){
	python_domodule MaskDetail.py
}
