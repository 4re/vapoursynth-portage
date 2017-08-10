# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Allows easy remapping of frames in a clip through the use of a text file or an input string"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-RemapFrames"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-RemapFrames"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-RemapFrames/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
	>=dev-util/meson-0.28.0
	virtual/pkgconfig
"

src_prepare(){
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
