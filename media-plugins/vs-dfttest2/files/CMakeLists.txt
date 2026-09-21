cmake_minimum_required(VERSION 3.22)

if(NOT DEFINED SKBUILD_PROJECT_VERSION)
  set(SKBUILD_PROJECT_VERSION "0.0.0")
endif()

project(DFTTEST2_CPU_Package VERSION "${SKBUILD_PROJECT_VERSION}" LANGUAGES CXX)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# === VapourSynth Include Resolution ===
find_path(
  VAPOURSYNTH_INCLUDE_DIR
  NAMES VapourSynth4.h VapourSynth.h
  HINTS
    "${CMAKE_CURRENT_SOURCE_DIR}/../../.venv/Lib/site-packages/vapoursynth/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/.venv/Lib/site-packages/vapoursynth/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../vapoursynth/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/vapoursynth/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/vapoursynth"
    "${CMAKE_CURRENT_SOURCE_DIR}/.venv/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/.venv/Lib/site-packages/vapoursynth"
  PATH_SUFFIXES vapoursynth/include vapoursynth include
  DOC "Path to VapourSynth headers"
)

find_package(PkgConfig QUIET MODULE)

if(PKG_CONFIG_FOUND)
    pkg_search_module(VS vapoursynth)

    if(VS_FOUND)
        message(${VAPOURSYNTH_INCLUDE_DIR})
        set(VAPOURSYNTH_INCLUDE_DIR ${VS_INCLUDE_DIRS} CACHE PATH "Path to VapourSynth headers" FORCE)
    endif()
endif()

if(VAPOURSYNTH_INCLUDE_DIR)
  message(STATUS "Found VapourSynth headers: ${VAPOURSYNTH_INCLUDE_DIR}")
else()
    message(FATAL_ERROR "${VAPOURSYNTH_INCLUDE_DIR} VapourSynth headers not found. Ensure vapoursynth>=75 is installed.")
endif()

set(SRC_DFTTEST2_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(VCL_HOME "${SRC_DFTTEST2_DIR}/cpu_source/vectorclass")

if(
  CMAKE_CXX_COMPILER_ID STREQUAL "GNU"
  OR CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "GNU"
  OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND NOT CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
)
  set(CPU_DISPATCH_TARGETS "sse2;avx2;avx512f" CACHE STRING "Dispatch targets")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC" OR CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
  set(CPU_DISPATCH_TARGETS "AVX;AVX2;AVX512" CACHE STRING "Dispatch targets")
endif()

message(STATUS "cpu targets: ${CPU_DISPATCH_TARGETS}")

add_library(dfttest2_cpu MODULE "${SRC_DFTTEST2_DIR}/cpu_source/source.cpp" "${VCL_HOME}/instrset_detect.cpp")

set_target_properties(
  dfttest2_cpu
  PROPERTIES CXX_EXTENSIONS OFF CXX_STANDARD 20 CXX_STANDARD_REQUIRED ON
)

target_include_directories(
  dfttest2_cpu
  PRIVATE "${SRC_DFTTEST2_DIR}/cpu_source" "${VCL_HOME}" "${VAPOURSYNTH_INCLUDE_DIR}" "${CMAKE_CURRENT_BINARY_DIR}"
)

if(NOT PROJECT_VERSION_MAJOR)
  set(PROJECT_VERSION_MAJOR 1)
endif()
if(NOT PROJECT_VERSION_MINOR)
  set(PROJECT_VERSION_MINOR 0)
endif()

target_compile_definitions(
  dfttest2_cpu
  PRIVATE
    PLUGIN_VERSION_MAJOR=${PROJECT_VERSION_MAJOR}
    PLUGIN_VERSION_MINOR=${PROJECT_VERSION_MINOR}
    PLUGIN_VERSION_STRING="v${PROJECT_VERSION}"
)

if(CPU_DISPATCH_TARGETS)
  target_compile_definitions(dfttest2_cpu PRIVATE HAS_DISPATCH)

  set(GETFRAME_DECLARATIONS "")
  set(GETFRAME_PTRS "")
  set(SUPPORTED_ARCH_DECLARATIONS "")
  set(SUPPORTED_ARCH_PTRS "")
  set(SUPPORTED_ARCH_STRS "")

  foreach(arch_option ${CPU_DISPATCH_TARGETS})
    set(raw_arch_option ${arch_option})
    string(REPLACE "=" "_" arch ${arch_option})
    string(REPLACE "-" "_" arch ${arch})

    if(
      CMAKE_CXX_COMPILER_ID STREQUAL "GNU"
      OR CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "GNU"
      OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND NOT CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
    )
      if(${arch_option} STREQUAL avx2)
        set(arch_option ${arch_option} -mfma)
      elseif(${arch_option} STREQUAL avx512f)
        if(WIN32)
          set(
            arch_option
            ${arch_option}
            -mfma
            -mavx512vl
            -mavx512bw
            -mavx512dq
          )
        else()
          set(arch_option ${arch_option} -mfma)
        endif()
      endif()
    endif()

    set(current_target getframe_impl_${arch})
    set(current_getframe_name DFTTestGetFrame_${arch})
    set(current_supported_arch_name supported_arch_${arch})

    add_library(${current_target} OBJECT "${SRC_DFTTEST2_DIR}/cpu_source/getframe_impl.cpp")

    set_target_properties(
      ${current_target}
      PROPERTIES CXX_EXTENSIONS OFF CXX_STANDARD 20 CXX_STANDARD_REQUIRED ON POSITION_INDEPENDENT_CODE ON
    )

    target_compile_definitions(${current_target} PRIVATE HAS_DISPATCH)
    target_compile_definitions(${current_target} PRIVATE DFTTEST_GETFRAME_NAME=${current_getframe_name})
    target_compile_definitions(${current_target} PRIVATE SUPPORTED_ARCH_NAME=${current_supported_arch_name})

    if(
      CMAKE_CXX_COMPILER_ID STREQUAL "GNU"
      OR CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "GNU"
      OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND NOT CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
    )
      target_compile_options(${current_target} PRIVATE -m${arch_option})
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC" OR CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
      target_compile_options(${current_target} PRIVATE /arch:${arch_option})
    endif()

    target_include_directories(
      ${current_target}
      PRIVATE "${SRC_DFTTEST2_DIR}/cpu_source" "${VCL_HOME}" "${VAPOURSYNTH_INCLUDE_DIR}" "${CMAKE_CURRENT_BINARY_DIR}"
    )

    string(
      APPEND GETFRAME_DECLARATIONS
      "
        extern const VSFrame *VS_CC ${current_getframe_name}(
            int n, int activationReason, void *instanceData, void **frameData,
            VSFrameContext *frameCtx, VSCore *core, const VSAPI *vsapi
        ) noexcept;\n"
    )

    string(APPEND GETFRAME_PTRS ${current_getframe_name},)
    string(APPEND SUPPORTED_ARCH_DECLARATIONS "extern bool ${current_supported_arch_name}() noexcept;\n")
    string(APPEND SUPPORTED_ARCH_PTRS ${current_supported_arch_name},)
    string(APPEND SUPPORTED_ARCH_STRS \"${raw_arch_option}\",)

    target_link_libraries(dfttest2_cpu PRIVATE ${current_target})
  endforeach()

  configure_file("${SRC_DFTTEST2_DIR}/cpu_source/cpu_dispatch.h.in" cpu_dispatch.h @ONLY)

  target_compile_definitions(dfttest2_cpu PRIVATE GETFRAME_PTRS=${GETFRAME_PTRS})
  target_compile_definitions(dfttest2_cpu PRIVATE SUPPORTED_ARCH_PTRS=${SUPPORTED_ARCH_PTRS})
  target_compile_definitions(dfttest2_cpu PRIVATE SUPPORTED_ARCH_STRS=${SUPPORTED_ARCH_STRS})
else()
  add_library(getframe_impl OBJECT "${SRC_DFTTEST2_DIR}/cpu_source/getframe_impl.cpp")

  set_target_properties(
    getframe_impl
    PROPERTIES CXX_EXTENSIONS OFF CXX_STANDARD 20 CXX_STANDARD_REQUIRED ON POSITION_INDEPENDENT_CODE ON
  )

  target_include_directories(
    getframe_impl
    PRIVATE "${SRC_DFTTEST2_DIR}/cpu_source" "${VCL_HOME}" "${VAPOURSYNTH_INCLUDE_DIR}"
  )

  target_link_libraries(dfttest2_cpu PRIVATE getframe_impl)
endif()

add_custom_target(build_cpu ALL DEPENDS dfttest2_cpu)

install(TARGETS dfttest2_cpu LIBRARY DESTINATION .)

if(WIN32)
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/manifest.vs" "[VapourSynth Manifest V1]\ndfttest2_cpu\n")
else()
  file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/manifest.vs" "[VapourSynth Manifest V1]\nlibdfttest2_cpu\n")
endif()
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/manifest.vs" DESTINATION .)
