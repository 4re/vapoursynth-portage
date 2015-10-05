# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit toolchain-funcs multilib eutils

DESCRIPTION="An optimized pixelwise OpenCL implementation of the Non-local means denoising algorithm"
HOMEPAGE="https://github.com/Khanattila/KNLMeansCL"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Khanattila/KNLMeansCL.git"
# 	EGIT_COMMIT=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Khanattila/KNLMeansCL/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
fi

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
CARDS=( nvidia )
IUSE="${CARDS[@]/#/video_cards_}"

RDEPEND+="
	media-libs/vapoursynth
	virtual/opencl
	video_cards_nvidia? ( x11-drivers/nvidia-drivers[uvm] )
"
DEPEND="${RDEPEND}
"


pkg_setup() {
	OPENCLOLD=$(eselect opencl show)
	if use video_cards_nvidia && [[ "${OPENCLOLD}" != "mesa" ]]; then
		elog "This packages will switch your current opencl working implementation,"
		elog "try to emerge this package individually if the build happens to fail."
		elog ""
		eselect opencl set mesa  || die "eselect can't find mesa opencl implementation."
	fi
}

src_prepare() {
	chmod +x configure
}

src_configure() {
	sed -i -e "s:CXX=\"g++\":CXX=\"$(tc-getCXX)\":" configure || die
	sed -i -e "s:LD=\"g++\":LD=\"$(tc-getCXX)\":" configure || die

	./configure \
		--install="${ED}/usr/$(get_libdir)/vapoursynth/" \
		--extra-cxxflags="${CXXFLAGS}" --extra-ldflags="${LDFLAGS}" || die "configure failed"
}

pkg_postinst() {
	if use video_cards_nvidia; then
		eselect opencl set ${OPENCLOLD}
	fi
}

src_install() {
	emake install
	dodoc README.md
}

