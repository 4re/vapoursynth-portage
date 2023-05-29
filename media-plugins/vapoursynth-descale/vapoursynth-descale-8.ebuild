# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit meson python-single-r1

DESCRIPTION="VapourSynth plugin to undo upscaling"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vapoursynth-descale/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="WTFPL-2"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth:0/4
"
DEPEND="${RDEPEND}"

DOCS=( "README.md" )


src_configure() {
	local emesonargs=(
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_domodule descale.py
}
