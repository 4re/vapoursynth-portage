# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {15..19} )

inherit git-r3 meson llvm-r1

DESCRIPTION="Akarin's experimental VapourSynth plugin"
HOMEPAGE="https://github.com/AkarinVS/vapoursynth-plugin"
EGIT_REPO_URI="https://github.com/Jaded-Encoding-Thaumaturgy/akarin-vapoursynth-plugin.git"

if ver_test ${PV} -ne 9999; then
	EGIT_COMMIT_DATE="${PV}"
	KEYWORDS="~amd64 ~x86"
else
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
