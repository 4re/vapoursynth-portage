# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_MAX_SLOT=15

inherit meson llvm

DESCRIPTION="Akarin's experimental VapourSynth plugin"
HOMEPAGE="https://github.com/AkarinVS/vapoursynth-plugin"

if ver_test ${PV} -ne 9999; then
	SRC_URI="https://github.com/AkarinVS/vapoursynth-plugin/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AkarinVS/vapoursynth-plugin.git"
	KEYWORDS=""
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="
	${RDEPEND}
	<=sys-devel/llvm-${LLVM_MAX_SLOT}
"

if ver_test ${PV} -ne 9999; then
	S="${WORKDIR}/vapoursynth-plugin-${PV}"
fi

src_configure() {
	local emesonargs=(
		-Dstatic-llvm=false
	)
	meson_src_configure
}
