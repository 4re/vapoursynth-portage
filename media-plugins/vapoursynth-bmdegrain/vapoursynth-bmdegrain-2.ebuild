# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="development prototype for block-matching-based denoising"
HOMEPAGE="https://github.com/AmusementClub/vs-bmdegrain"

if ver_test -ne 9999; then
	SRC_URI="https://github.com/AmusementClub/vs-bmdegrain/archive/test${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AmusementClub/vs-bmdegrain.git"
	KEYWORDS=""
fi

LICENSE="MIT"
SLOT="0"
IUSE="cpu_flags_x86_avx2"

RDEPEND+="
	media-libs/vapoursynth
	cpu_flags_x86_avx2? (
		sci-libs/vectorclass
	)
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

if ver_test -ne 9999; then
	S="${WORKDIR}/${PN/vapoursynth/vs}-test${PV}"
fi

# src_configure() {
# 	local mycmakeargs=(
# 		-DMKL_THREADING=sequential
# 		-DMKL_INTERFACE=lp64
# 	)
# 	cmake_src_configure
# }
