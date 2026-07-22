# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )

inherit python-single-r1 toolchain-funcs

DESCRIPTION="EdgeFixer repairs bright and dark line artifacts near the border of an image"
HOMEPAGE="https://github.com/sekrit-twc/EdgeFixer"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sekrit-twc/EdgeFixer.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/sekrit-twc/EdgeFixer/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
RESTRICT="mirror"

RDEPEND+="
	>=media-libs/vapoursynth-76[${PYTHON_SINGLE_USEDEP}]
"
DEPEND="${RDEPEND}
"

LIBNAME="libedgefixer.so"
EXTRAFLAGS="-fPIC -shared"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${EXTRAFLAGS} ${LDFLAGS} \
		-I$(vapoursynth get-include) \
		-o ${LIBNAME} \
		EdgeFixer/edgefixer.c EdgeFixer/vsplugin.c || die "Build failed"
}

src_install() {
	insinto "$(vapoursynth get-plugin-dir)"
	doins ${LIBNAME}
}
