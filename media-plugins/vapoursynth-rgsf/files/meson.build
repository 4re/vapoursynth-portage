project('RGSF', 'cpp',
  version : 'r5',
  default_options : ['warning_level=3', 'cpp_std=c++14']
)

# Taken from Akarin's vapoursynth-plugin 'meson.build'
vapoursynth_dep = dependency('vapoursynth').partial_dependency(compile_args: true, includes: true)

shared_module(
  'rgsf',
  'Clense.cpp',
  'RGVS.cpp',
  'RemoveGrain.cpp',
  'Repair.cpp',
  'VerticalCleaner.cpp',
  dependencies: [vapoursynth_dep],
  install : true,
  install_dir: join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth'),
  gnu_symbol_visibility: 'hidden'
)
