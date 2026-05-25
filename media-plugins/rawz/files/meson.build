project('RAWZ', 'cpp',
    default_options: ['buildtype=release', 'warning_level=2', 'b_lto=true', 'b_ndebug=if-release', 'cpp_std=c++17'],
    license: 'WTFPL',
    license_files: 'COPYING',
    meson_version: '>=1.2.3',
    version: '1.0',
)

rawz_sources = [
	'rawz/checked_int.h',
	'rawz/common.h',
	'rawz/io.h',
	'rawz/rawz.h',
	'rawz/stream.h',
	'rawz/interleaved.cpp',
	'rawz/io.cpp',
	'rawz/nv.cpp',
	'rawz/planar.cpp',
    'rawz/rawz.cpp',
	'rawz/stream.cpp',
	'rawz/y4m.cpp'
]

vsrawz_sources = [
	'vsrawz/vsrawz.cpp',
]

p2p_sources = [
	'libp2p/p2p.h',
	'libp2p/simd/cpuinfo_x86.h',
	'libp2p/simd/p2p_simd.h',
    'libp2p/simd/p2p_simd.cpp',
    'libp2p/simd/cpuinfo_x86.cpp',
    'libp2p/v210.cpp',
]

vsxx_sources = [
	'vsxx/vapoursynth/VapourSynth4.h',
	'vsxx/vapoursynth/VSConstants4.h',
	'vsxx/vapoursynth/VSHelper4.h',
	'vsxx/VapourSynth4++.hpp',
	'vsxx/vsxx4_pluginmain.h',
    'vsxx/vsxx4_pluginmain.cpp'
]

sources = p2p_sources + vsxx_sources + rawz_sources + vsrawz_sources

incdir = include_directories(
    'libp2p',
    'rawz',
    'vsxx',
    'vsxx/vapoursynth'
)

cxx = meson.get_compiler('cpp')

add_project_arguments(
    cxx.get_supported_arguments(
        '-DP2P_USER_NAMESPACE=p2p_rawz',
    ),
    language: 'cpp',
)

libs = []

if host_machine.cpu_family() in ['x86', 'x86_64']    
    add_project_arguments(
        cxx.get_supported_arguments(
            '-D_CRT_SECURE_NO_WARNINGS',
            '-DP2P_SIMD',
        ),
        language: 'cpp',
    )
    
    libs += static_library('p2p_sse41', 'libp2p/simd/p2p_sse41.cpp',
        include_directories: incdir,
        cpp_args: ['-msse4.1']
    )
endif

py = import('python').find_installation(pure: false)

shared_module('vsrawz',
    sources,
    gnu_symbol_visibility: 'hidden',
    include_directories: incdir,
    link_with: libs,
    install: true,
    install_dir: py.get_install_dir() / 'vapoursynth/plugins',
    name_prefix: '',
)
