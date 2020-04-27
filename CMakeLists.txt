# Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
# Copyright 2017-2019 University of Huddersfield.
# Licensed under the BSD-3 License.
# See license.md file in the project root for full license information.
# This project has received funding from the European Research Council (ERC)
# under the European Union’s Horizon 2020 research and innovation programme
# (grant agreement No 725899).

cmake_minimum_required(VERSION 3.11)
################################################################################
# Paths
set(MAX_TARGET_NAMESPACE "" CACHE STRING "Optional namesapce to prepend to targets to prevent collision in super-builds")
set(MAX_SDK_PATH "" CACHE PATH "Path to the Max SDK")
if(NOT MAX_SDK_PATH)
  message(FATAL_ERROR "Max SDK Path is not set")
endif()

set(FLUID_PATH "" CACHE PATH "Optional path to the Fluid Decomposition repo")
# set(FLUID_M_PATH "" CACHE PATH "Optional path to the Fluid fluid_manipulation repo")

option(DOCS "Generate Max XML documentation" OFF)
set(FLUID_PARAMDUMP_PATH "" CACHE PATH "Optional path to fluid_paramdump (needed for docs)")

if (APPLE)
  set(CMAKE_XCODE_GENERATE_SCHEME ON)
  set(CMAKE_XCODE_SCHEME_EXECUTABLE "/Applications/Max.app")
  set(CMAKE_OSX_DEPLOYMENT_TARGET 10.8)
endif()

################################################################################
# Main Action
project (flucoma-max LANGUAGES CXX)

# XCODE_VERSION Doesn't work before project() call 
if(APPLE AND XCODE_VERSION VERSION_GREATER_EQUAL 10)
  set(FLUID_OSX_ARCHS x86_64)
else()
  set(FLUID_OSX_ARCHS x86_64;i386)
endif()  

set(CMAKE_XCODE_GENERATE_TOP_LEVEL_PROJECT_ONLY ON)
set(AUTHOR_DOMAIN "org.flucoma")
string(TIMESTAMP "%Y" THISYEAR)
set(COPYRIGHT_STRING "Copyright (c) 2017-${THISYEAR} University of Huddersfield")
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
################################################################################
# Fetch / link to dependencies
include(FetchContent)

set(FETCHCONTENT_QUIET FALSE)

FetchContent_Declare(
  fluid_decomposition
  GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_decomposition.git
  GIT_PROGRESS TRUE
)

FetchContent_Declare(
  fluid_paramdump
  GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_paramdump.git
  GIT_PROGRESS TRUE  
)

if(FLUID_PATH)
  get_filename_component(
    FETCHCONTENT_SOURCE_DIR_FLUID_DECOMPOSITION ${FLUID_PATH} ABSOLUTE
  )
endif()

FetchContent_GetProperties(fluid_decomposition)

if(NOT fluid_decomposition_POPULATED)
  FetchContent_Populate(fluid_decomposition)
  add_subdirectory(${fluid_decomposition_SOURCE_DIR} ${fluid_decomposition_BINARY_DIR})  
  include(flucoma_version)
  include(flucoma-buildtools)
endif()

set_if_toplevel(VAR CMAKE_LIBRARY_OUTPUT_DIRECTORY 
                TOPLEVEL "${CMAKE_CURRENT_SOURCE_DIR}/externals"
                SUPERBUILD "${CMAKE_SOURCE_DIR}/max_externals")


if(DOCS)
  if(FLUID_PARAMDUMP_PATH)
    get_filename_component(
      FETCHCONTENT_SOURCE_DIR_FLUID_PARAMDUMP ${FLUID_PARAMDUMP_PATH} ABSOLUTE
    )
  endif()

  FetchContent_GetProperties(fluid_paramdump)
  if(NOT fluid_paramdump_POPULATED)
    FetchContent_Populate(fluid_paramdump)
    file(GLOB_RECURSE DOC_SOURCE RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${fluid_paramdump_SOURCE_DIR}/**/*.cpp" )
    source_group("\\XML Doc Gen" FILES ${DOC_SOURCE})
    add_subdirectory(${fluid_paramdump_SOURCE_DIR} ${fluid_paramdump_BINARY_DIR})
  endif()
  
  add_custom_target(MAX_MAKE_DOCS ALL DEPENDS MAKE_MAX_REF)
  add_custom_command(TARGET MAX_MAKE_DOCS POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory "${FLUID_MAX_REF_PATH}"  "${CMAKE_CURRENT_SOURCE_DIR}/docs"
    COMMENT "${FLUID_MAX_REF_PATH}"
  )
endif()

# Misc setup and subroutines
include("${CMAKE_CURRENT_SOURCE_DIR}/source/script/max-package.cmake")

# only on Max do we need UBs
set_property(TARGET HISSTools_FFT PROPERTY OSX_ARCHITECTURES ${FLUID_OSX_ARCHS})

################################################################################
# Max Wrapper
add_library( FLUID_MAX INTERFACE )
target_sources(
	FLUID_MAX INTERFACE
	"${CMAKE_CURRENT_SOURCE_DIR}/source/include/FluidMaxWrapper.hpp"
	"${CMAKE_CURRENT_SOURCE_DIR}/source/include/MaxBufferAdaptor.hpp"
)

################################################################################
# Generate a project for every folder in the "source/projects" folder
SUBDIRLIST(PROJECT_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/source/projects")
foreach (project_dir ${PROJECT_DIRS})
	if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir}/CMakeLists.txt")
		message("Generating: ${MAX_TARGET_NAMESPACE}${project_dir}")
		add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir}")
    source_group("" FILES "${project_dir}.cpp")
	endif ()
endforeach ()

################################################################################
#install bits. Max packages bundle Windows and Mac builds together 
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/release-packaging")
set(MAX_INSTALL_PREFIX "." CACHE PATH "Prefix for assembling max package")
set(FLUID_PACKAGE_NAME FluidCorpusManipulation CACHE STRING "Name for published package")
set(MAX_PACKAGE_ROOT ${MAX_INSTALL_PREFIX}/${FLUID_PACKAGE_NAME})

foreach(PACKAGE_DIRECTORY examples;extras;help;init)
  install(DIRECTORY ${PACKAGE_DIRECTORY} DESTINATION ${MAX_PACKAGE_ROOT})
endforeach(PACKAGE_DIRECTORY)

install(DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/ DESTINATION ${MAX_PACKAGE_ROOT}/externals FILES_MATCHING REGEX "\\.(mxo|mxe|mxe64)")

# install(CODE [[ message(STATUS "${fluid_decomposition_SOURCE_DIR}") ]])
install(DIRECTORY "${fluid_decomposition_SOURCE_DIR}/AudioFiles/" DESTINATION "${MAX_PACKAGE_ROOT}/media")
install(FILES icon.png package-info.json QuickStart.md DESTINATION ${MAX_PACKAGE_ROOT})
install(FILES ${fluid_decomposition_SOURCE_DIR}/distribution.lic DESTINATION ${MAX_PACKAGE_ROOT} RENAME LICENSE.md)

if(DOCS)
  install(DIRECTORY "${FLUID_MAX_REF_PATH}/" DESTINATION "${MAX_PACKAGE_ROOT}/docs"  PATTERN "*.xml")
endif()
