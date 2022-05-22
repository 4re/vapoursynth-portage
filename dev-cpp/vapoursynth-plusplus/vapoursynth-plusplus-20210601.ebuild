# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="C++ wrapper for VSAPI to help you sketch your filter in the fastest possible way"
HOMEPAGE="https://github.com/IFeelBloated/vapoursynth-plusplus"

EGIT_REPO_URI="https://github.com/IFeelBloated/vapoursynth-plusplus.git"
EGIT_COMMIT="bb99dd4ee700e4d37454977dc229938034425a3a"
KEYWORDS="~amd64"

LICENSE=""
SLOT="0"
IUSE="examples lto plugin"
RESTRICT="mirror"

RDEPEND+="
	media-libs/vapoursynth:0/4
"
DEPEND="${RDEPEND}
"

src_prepare() {
	cat << EOF > meson.build
project('vapoursynth-plusplus', 'cpp', 
    default_options: ['buildtype=release', 'b_ndebug=if-release', 'cpp_std=c++2a'],
    version : '3'
)

if host_machine.cpu_family().startswith('x86')
  add_project_arguments('-mfpmath=sse', '-msse2', language : 'cpp')
endif

pkg = import('pkgconfig')
deps = dependency('vapoursynth')

incdir = include_directories('include')

test_plug = ['Examples/EntryPoint.cxx']

headers = [
    'include/AudioFrame.vxx',
    'include/AudioNode.vxx',
    'include/Core.vxx',
    'include/DescriptiveAggregates.vxx',
    'include/Enumerations.vxx',
    'include/Frame.vxx',
    'include/Function.vxx',
    'include/Infrastructure.vxx',
    'include/LoggerController.vxx',
    'include/Map.vxx',
    'include/Node.vxx',
    'include/Plane.vxx',
    'include/Plugin.vxx',
    'include/PluginInstantiator.vxx',
    'include/Range.vxx',
    'include/ResourceManager.vxx',
    'include/UniversalContext.vxx',
    'include/Utility.vxx',
    'include/VideoFrame.vxx',
    'include/VideoNode.vxx'
]

examples = [
    'Examples/Crop.hxx',
    'Examples/EntryPoint.cxx',
    'Examples/GaussBlurFast.hxx',
    'Examples/GaussBlur.hxx',
    'Examples/ModifyFrameExample.vpy',
    'Examples/ModifyFrame.hxx',
    'Examples/Palette.hxx',
    'Examples/Rec601ToRGB.hxx',
    'Examples/SeparableConvolution.hxx',
    'Examples/TemporalMedian.hxx',
]

if get_option('install_examples')
    install_data(examples, install_dir : 'share/vapoursynth-plusplus/Examples')
endif

if get_option('build_examples')
    shared_module('vsfilterscriptexample',
        test_plug,
        include_directories : incdir,
        dependencies : deps,
        gnu_symbol_visibility : 'hidden',
        install_dir : join_paths(deps.get_pkgconfig_variable('libdir'), 'vapoursynth'),
        install : true
    )
endif

install_headers(headers, subdir : 'vapoursynth-plusplus')

pkg.generate(
    name : 'vapoursynth-plusplus',
    subdirs : 'vapoursynth-plusplus',
    version : meson.project_version(),
    description : 'C++ wrapper for VSAPI to help you sketch your filter in the fastest possible way.'
)
EOF
	default
}

src_configure() {
	local emesonargs=(
		-Dbuild_examples=$(usex plugin true false)
		-Dinstall_examples=$(usex examples true false)
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
