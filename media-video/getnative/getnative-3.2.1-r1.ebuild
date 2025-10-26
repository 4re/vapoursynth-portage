# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Find the native resolution(s) of upscaled material (mostly anime)"
HOMEPAGE="https://github.com/Infiziert90/getnative"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Infiziert90/getnative.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Infiziert90/getnative/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/matplotlib
	media-libs/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	media-plugins/vapoursynth-descale
	|| ( media-plugins/vapoursynth-ffmpegsource media-plugins/vapoursynth-l-smash-works media-libs/vapoursynth[imagemagick] )
"
RDEPEND="${DEPEND}"

DOCS=( "README.md" )

src_prepare(){
	default
	sed -ni '/VapourSynth/!p' requirements.txt || die "sed failed."
}
