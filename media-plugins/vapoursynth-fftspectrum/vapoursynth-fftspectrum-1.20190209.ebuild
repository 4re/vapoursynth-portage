# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A VapourSynth filter that displays the FFT frequency spectrum of a given clip"
HOMEPAGE="https://github.com/Beatrice-Raws/FFTSpectrum"

inherit git-r3 meson

EGIT_REPO_URI="https://github.com/Beatrice-Raws/FFTSpectrum.git"
EGIT_COMMIT="0fe516062c1b0fe41983f77fdbf3bd6e8f8d43c1"

KEYWORDS="~amd64 ~x86"
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
