# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

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
	>=dev-python/typing-extensions-4.15.0
"

distutils_enable_tests pytest
