# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Fix Telecined Fades"
HOMEPAGE="https://github.com/IFeelBloated/Fix-Telecined-Fades"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/Fix-Telecined-Fades"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/IFeelBloated/Fix-Telecined-Fades/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	>=dev-util/meson-0.28.0
	virtual/pkgconfig
"

src_prepare(){
	rm VSHelper.h VapourSynth.h
	mkdir build
	eapply_user
}

src_configure(){
	cd build
	meson \
		--prefix="${EPREFIX}/usr" \
		--buildtype=plain \
		.. || die
}

src_compile(){
	cd build
	ninja -v
}

src_install(){
	cd build
	DESTDIR="${D}" ninja install
}
