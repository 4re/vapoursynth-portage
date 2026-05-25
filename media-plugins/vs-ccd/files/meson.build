project(
    'ccd',
    'cpp',
    version: '0.3.1',
    default_options: [
        'warning_level=3',
        'buildtype=release',
        'b_ndebug=if-release',
        'cpp_std=c++11',
    ],
    meson_version: '>=0.64',
)

if host_machine.cpu_family().startswith('x86')
    add_project_arguments('-mfpmath=sse', '-msse2', language: 'cpp')
endif

host_system = host_machine.system()

if host_system == 'windows' or host_system == 'cygwin'
    add_project_link_arguments('-static', language: 'cpp')
    if host_machine.cpu_family() == 'x86'
        add_project_arguments('-mstackrealign', language: 'cpp')
        add_project_link_arguments('-Wl,--kill-at', language: 'cpp')
    endif
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
    'ccd',
    'src/ccd.cpp',
    include_directories: incdir,
    install_dir: py.get_install_dir() / 'vapoursynth/plugins',
    install: true,
)
