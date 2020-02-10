# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="A VapourSynth filter that displays the FFT frequency spectrum of a given clip"
HOMEPAGE="https://github.com/Beatrice-Raws/FFTSpectrum"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Beatrice-Raws/FFTSpectrum.git"
	KEYWORDS=""
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/Beatrice-Raws/FFTSpectrum/archive/r${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="cpu_flags_x86_sse4"
REQUIRED_USE="cpu_flags_x86_sse4"

RDEPEND+="
	media-libs/vapoursynth
	sci-libs/fftw:3.0
"
DEPEND="${RDEPEND}
"

src_prepare(){
cat << EOF > meson.build
project('FFTSpectrum',
        'c',
        default_options : ['c_std=c11'],
        license : ['GPL-2.0'],
        version : '1')

add_project_arguments('-msse4', language : 'c')

cc = meson.get_compiler('c')
m = cc.find_library('m', required : false)
vs = dependency('vapoursynth')
fft = dependency('fftw3f')

deps = [m, vs, fft]

src = ['FFTSpectrum.c']

library(
    'fftspectrum',
    src,
    dependencies : deps,
    install_dir : join_paths(get_option('prefix'), get_option('libdir'), 'vapoursynth'),
    install : true
)
EOF
eapply_user
}
