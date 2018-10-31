# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Image super-resolution/denoise filter for VapourSynth, based on the waifu2x-opt library"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Waifu2x-w2xc"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="debug"

RDEPEND+="
	media-libs/vapoursynth
	>=media-libs/waifu2x-converter-cpp-6_pre
"
DEPEND="${RDEPEND}
"


src_prepare() {
	eapply_user
	./autogen.sh
}

src_configure() {
	econf --libdir="/usr/$(get_libdir)/vapoursynth/"
}

src_install() {
	emake DESTDIR="${D}" install
	cp -R "${S}/Waifu2x-w2xc/models/" "${D}/usr/$(get_libdir)/vapoursynth" || die
}
