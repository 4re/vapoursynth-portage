# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-utils-r1 python-single-r1 git-r3

DESCRIPTION="Line darkening script for VapourSynth"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-Hysteria"

EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-Hysteria.git"
EGIT_COMMIT="34353f08f55564d0094e6e1c5057dd84b82faa32"
KEYWORDS="~amd64 ~x86"

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
