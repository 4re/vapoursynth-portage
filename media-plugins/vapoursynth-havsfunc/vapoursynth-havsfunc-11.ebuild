# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="3:3.3"
RESTRICT_PYTHON_ABIS="2.* 3.[0123]"

inherit python

DESCRIPTION="HolyWu's ported AviSynth scripts for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166582"
SRC_URI="https://dl.dropbox.com/u/6596386/vapoursynth-plugins/havsfunc-r${PV}.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}"

src_install(){
	insinto "$(python_get_sitedir)"
	doins havsfunc.py
}
