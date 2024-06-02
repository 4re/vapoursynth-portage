# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
AUTOTOOLS_AUTORECONF=1

inherit python-single-r1

DESCRIPTION="MVTools is a set of filters for motion estimation and compensation"
HOMEPAGE="https://github.com/IFeelBloated/vapoursynth-mvtools-sf"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/IFeelBloated/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0
"
DEPEND="${RDEPEND}
"

DOCS=( README.md )

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${P}-autotools.patch"
	./autogen.sh
}

src_configure() {
	econf --libdir="${ED}/usr/$(get_libdir)/vapoursynth/" || die "configure failed"
}

src_install() {
	emake install
	python_domodule src/mvmulti.py
}
