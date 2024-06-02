# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1 git-r3

DESCRIPTION="Line darkening script for VapourSynth"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-Hysteria"

EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-Hysteria.git"
EGIT_COMMIT="32c301447a7ab9690664ac454ed2a135624dbed3"
KEYWORDS="~amd64 ~x86"

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-miscfilters-obsolete
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule hysteria.py
}
