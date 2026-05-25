# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=true
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 git-r3

DESCRIPTION="Generates film like noise or other effects (like rain) by adding random noise to a video clip"
HOMEPAGE="https://github.com/wwww-wwww/vs-noise"
EGIT_REPO_URI="https://github.com/wwww-wwww/vs-noise.git"

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	EGIT_COMMIT="refs/tags/r${PV}"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3	"
SLOT="0"
IUSE="lto"
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )
