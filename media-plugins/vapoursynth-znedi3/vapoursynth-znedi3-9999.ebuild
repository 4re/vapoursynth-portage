# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Optimized nnedi3 filter"
HOMEPAGE="https://github.com/sekrit-twc/znedi3"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sekrit-twc/znedi3.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/sekrit-twc/znedi3/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_compile() {
	emake CPPFLAGS="-DNNEDI3_WEIGHTS_PATH=\\\"\"${EROOT}usr/share/znedi3/nnedi3_weights.bin\"\\\"" X86=1
}

src_install() {
	insinto "/usr/$(get_libdir)/vapoursynth/"
	doins vsznedi3.so
	insinto "/usr/share/znedi3"
	doins nnedi3_weights.bin
}
