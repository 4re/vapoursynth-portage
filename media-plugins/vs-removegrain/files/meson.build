project(
    'removegrain',
    'cpp',
    version: '1',
    default_options: [
        'warning_level=3',
        'buildtype=release',
        'b_ndebug=if-release',
    ],
)

add_project_arguments('-ffast-math', language: 'cpp')

sources = [
    'src/clense.cpp',
    'src/removegrainvs.cpp',
    'src/repairvs.cpp',
    'src/shared.cpp',
    'src/shared.h',
    'src/verticalcleaner.cpp',
]

if host_machine.cpu_family().startswith('x86')
    add_project_arguments(
        '-DVS_TARGET_CPU_X86',
        '-mfpmath=sse',
        '-msse2',
        language: 'cpp',
    )
endif

if host_machine.system() == 'windows'
    add_project_link_arguments('-static', language: 'cpp')
endif

py = import('python').find_installation(pure: false)

incdir = include_directories(
    run_command(
        py,
        '-c',
        'import vapoursynth as vs; print(vs.get_include())',
        check: true,
    ).stdout().strip(),
)

shared_module(
    'removegrain',
    sources,
    include_directories: incdir,
    install: true,
    install_dir: py.get_install_dir() / 'vapoursynth/plugins',
    gnu_symbol_visibility: 'hidden',
)
