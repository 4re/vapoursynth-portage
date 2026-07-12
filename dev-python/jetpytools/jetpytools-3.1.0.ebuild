# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{13..15} )

inherit distutils-r1 pypi

DESCRIPTION="Collection of stuff that's useful in general python programming."
HOMEPAGE="
	https://pypi.org/project/jetpytools/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-python/versioningit
"
RDEPEND="
"

distutils_enable_tests pytest
