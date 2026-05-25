# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="Setsugen No Ensemble of Edge Directed Interpolation Functions"
HOMEPAGE="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-SNEEDIF"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-SNEEDIF.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-SNEEDIF/archive/R${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="WTFPL GPL-3 BSD-3"
SLOT="0"
IUSE=""
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )
