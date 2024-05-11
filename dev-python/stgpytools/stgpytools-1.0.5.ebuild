# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 python3_12 )

inherit distutils-r1 pypi

DESCRIPTION="Collection of stuff that's useful in general python programming."
HOMEPAGE="
	https://pypi.org/project/stgpytools/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""

distutils_enable_tests pytest
