# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="RemoveGrain Single Precision"
HOMEPAGE="https://github.com/IFeelBloated/RGSF"

if ver_test -ne 9999; then
	SRC_URI="https://github.com/IFeelBloated/RGSF/archive/r${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IFeelBloated/RGSF.git"
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
"

if ver_test -ne 9999; then
	MY_PN="${PN/vapoursynth-/}"
	S="${WORKDIR}/${MY_PN^^}-r${PV}"
fi

src_unpack() {
	if ver_test -eq 9999; then
		git-r3_src_unpack
	else
		default
	fi

	# Upstream doesn't provide a buildsystem.
	cp -vr "${FILESDIR}/meson.build" "${S}/"
}

src_prepare() {
	# media-libs/vapoursynth provides these.
	rm -fr "VapourSynth.h" "VSHelper.h"

	default
}
