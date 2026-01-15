# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="Typing stubs for VapourSynth"
HOMEPAGE="
	https://pypi.org/project/vsstubs
	https://github.com/Ichunjo/vs-stubs
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/versioningit
"
RDEPEND="
	media-libs/vapoursynth
	dev-python/typer
	dev-python/rich
"
