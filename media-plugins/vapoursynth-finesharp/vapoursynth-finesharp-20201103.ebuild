# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1 git-r3

DESCRIPTION="Small and relatively fast realtime-sharpening function for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166524"
EGIT_REPO_URI="https://gist.github.com/8676fd350d4b5b223ab9.git"
EGIT_COMMIT="892023c42882eee7f4ec3b18a9b1cff43fdd9f40"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	>=media-libs/vapoursynth-47[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}"

src_install(){
	python_domodule finesharp.py
}
