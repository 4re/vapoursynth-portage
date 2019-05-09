# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
DISTUTILS_OPTIONAL=1

inherit distutils-r1

DESCRIPTION="Perceptual video quality assessment based on multi-method fusion."
HOMEPAGE="https://github.com/Netflix/vmaf/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Netflix/vmaf.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Netflix/vmaf/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="examples tools python"

DEPEND=""
RDEPEND="${DEPEND}
	python? (
		${PYTHON_DEPS}
		>=dev-python/numpy-1.12.0[${PYTHON_USEDEP}]
		>=sci-libs/scipy-0.17.1[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/pandas-0.19.2[${PYTHON_USEDEP}]
		>=sci-libs/scikits_learn-0.13.0[${PYTHON_USEDEP}]
		>=sci-libs/scikits_learn-0.18.1[${PYTHON_USEDEP}]
		>=dev-python/h5py-2.6.0[${PYTHON_USEDEP}]
	)
"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# python-r1 requires this to know that we are building in the python subdir
BUILD_DIR=${S}/python

src_prepare() {
	eapply_user

	# replace makefile with the one available for Linux
	rm ptools/Makefile
	ln -s Makefile.Linux ptools/Makefile

	# fix stupid makefile syntax errors
	sed -i ptools/Makefile.Linux -e 's; :;:;g'

	# fix install destination
	sed -i wrapper/Makefile -e "s;= /usr/local;= ${EPREFIX}/usr;g" \
		-e 's;mkdir -p $(DESTDIR)$(INSTALL_PREFIX)/share;mkdir -p $(DESTDIR)$(INSTALL_PREFIX)/share/vmaf;' \
		-e 's;cp -r ../model $(DESTDIR)$(INSTALL_PREFIX)/share/;cp -r ../model $(DESTDIR)$(INSTALL_PREFIX)/share/vmaf/;'
}

src_compile() {
	emake -C libsvm lib
	emake -C ptools libptools.so
	emake -C wrapper

	if use examples; then
		emake -C ptools
	fi

	if use tools; then
		emake -C libsvm
		emake -C feature
	fi
}
