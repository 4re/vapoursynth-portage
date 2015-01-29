# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="3"
RESTRICT_PYTHON_ABIS="2.* 3.[0123]"

inherit python git-2

DESCRIPTION="Small and relatively fast realtime-sharpening function for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166524"
EGIT_REPO_URI="https://gist.github.com/8676fd350d4b5b223ab9.git"

LICENSE=""
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
	doins finesharp.py
}
