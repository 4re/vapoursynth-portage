# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs meson

DESCRIPTION="Rapid, Detail-Preserving Image Downscaler for VapourSynth"
HOMEPAGE="https://github.com/WolframRhodium/VapourSynth-dpid"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WolframRhodium/VapourSynth-dpid.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/WolframRhodium/VapourSynth-dpid/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-3"
SLOT="0"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${S}/Source"
