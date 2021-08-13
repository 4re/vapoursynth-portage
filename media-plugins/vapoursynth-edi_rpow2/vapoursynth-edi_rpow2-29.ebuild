# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit python-single-r1 git-r3

DESCRIPTION="Helpers for x2 upsizing using edi filters."
HOMEPAGE="https://gist.github.com/YamashitaRen/020c497524e794779d9c"

EGIT_REPO_URI="https://gist.github.com/YamashitaRen/020c497524e794779d9c"
EGIT_COMMIT="2a20385e50804f8b24f2a2479e2c0f3c335d4853"
KEYWORDS="~amd64"

LICENSE=""
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-eedi2
	media-plugins/vapoursynth-fmtconv
	media-plugins/vapoursynth-nnedi3
	media-plugins/vapoursynth-nnedi3cl
	media-plugins/vapoursynth-znedi3
"
DEPEND="${RDEPEND}"

src_install(){
	python_domodule edi_rpow2.py
}
