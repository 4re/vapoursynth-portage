# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Optimized nnedi3 filter"
HOMEPAGE="https://github.com/sekrit-twc/znedi3"

EGIT_REPO_URI="https://github.com/sekrit-twc/znedi3.git"
EGIT_COMMIT="bbdabfd55f8ff781384aeb3a8fbb8b9a0a13e442"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

src_compile() {
	emake CPPFLAGS="-DNNEDI3_WEIGHTS_PATH=\\\"\"${EROOT}/usr/share/znedi3/nnedi3_weights.bin\"\\\"" X86=1
}

src_install() {
	insinto "/usr/$(get_libdir)/vapoursynth/"
	doins vsznedi3.so
	insinto "/usr/share/znedi3"
	doins nnedi3_weights.bin
}
