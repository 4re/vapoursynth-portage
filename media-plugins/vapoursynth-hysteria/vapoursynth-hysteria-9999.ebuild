# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1

DESCRIPTION="Line darkening script for VapourSynth"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-Hysteria"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-Hysteria.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-Hysteria/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP},vapoursynth_plugins_miscfilters]
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule hysteria.py
}
