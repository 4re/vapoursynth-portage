# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {15..19} )

inherit meson llvm-r1

DESCRIPTION="Akarin's experimental VapourSynth plugin"
HOMEPAGE="https://github.com/AkarinVS/vapoursynth-plugin"

if ver_test ${PV} -ne 9999; then
	COMMIT_HASH="62a5bae73a10ad344e6c02a228c03c5525854678"
	SRC_URI="
		https://github.com/Jaded-Encoding-Thaumaturgy/akarin-vapoursynth-plugin/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz
	"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/akarin-vapoursynth-plugin-${COMMIT_HASH}"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Jaded-Encoding-Thaumaturgy/akarin-vapoursynth-plugin.git"
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
	$(llvm_gen_dep '
		llvm-core/llvm:${LLVM_SLOT}=
	')
"

src_configure() {
	local emesonargs=(
		-Dstatic-llvm=false
	)
	meson_src_configure
}
