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
set(MAX_TARGET_NAMESPACE "" CACHE STRING "Optional namesapce to prepend to targets to prevent collision in superbuilds")
set(MAX_SDK_PATH "" CACHE PATH "Path to the Max SDK")
if(NOT MAX_SDK_PATH)
  message(FATAL_ERROR "Max SDK Path is not set")
endif()

set(FLUID_PATH "" CACHE PATH "Optional path to the Fluid Decomposition repo")
set(FLUID_M_PATH "" CACHE PATH "Optional path to the Fluid fluid_manipulation repo")

option(DOCS "Generate Max XML documentation" OFF)
set(FLUID_DOCS_PATH "" CACHE PATH "Optional path to flucoma-docs (needed for docs)")

if (APPLE)
  set(CMAKE_XCODE_GENERATE_SCHEME ON)
  set(CMAKE_XCODE_SCHEME_EXECUTABLE "/Applications/Max.app")
  set(CMAKE_OSX_DEPLOYMENT_TARGET "10.8" CACHE STRING "")
  #A consequence of targetting 10.8. Needs to be set globally from 10.15 onwards in order for the test program to compile successfully during configure 
  string(APPEND CMAKE_CXX_FLAGS " -stdlib=libc++")
endif()

################################################################################
# Main Action
project (flucoma-max LANGUAGES CXX)

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
  flucoma-core
  GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_decomposition.git
  GIT_PROGRESS TRUE
)

# FetchContent_Declare(
#   fluid_manipulation
#   GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_manipulation.git
#   GIT_PROGRESS TRUE
# )

FetchContent_Declare(
  flucoma-docs
  GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_paramdump.git
  GIT_PROGRESS TRUE  
)

if(FLUID_PATH)
  get_filename_component(
    FETCHCONTENT_SOURCE_DIR_FLUCOMA-CORE ${FLUID_PATH} ABSOLUTE
  )
endif()

FetchContent_GetProperties(flucoma-core)

if(NOT flucoma-core_POPULATED)
  FetchContent_Populate(flucoma-core)
  add_subdirectory(${flucoma-core_SOURCE_DIR} ${flucoma-core_BINARY_DIR})  
  include(flucoma_version)
  include(flucoma-buildtools)
  include(flucoma-buildtype)
endif()

set_if_toplevel(VAR CMAKE_LIBRARY_OUTPUT_DIRECTORY
                TOPLEVEL "${CMAKE_CURRENT_SOURCE_DIR}/externals"
                SUPERBUILD "${CMAKE_SOURCE_DIR}/max_externals")


# if(FLUID_M_PATH)
#   get_filename_component(
#     FETCHCONTENT_SOURCE_DIR_FLUID_MANIPULATION ${FLUID_M_PATH} ABSOLUTE
#   )
# endif()
#
# FetchContent_GetProperties(fluid_manipulation)
#
# if(NOT fluid_manipulation_POPULATED)
#   FetchContent_Populate(fluid_manipulation)
#   add_subdirectory(${fluid_manipulation_SOURCE_DIR} ${fluid_manipulation_BINARY_DIR})
# endif()


if(DOCS)
  if(FLUID_DOCS_PATH)
    get_filename_component(
      FETCHCONTENT_SOURCE_DIR_FLUCOMA-DOCS ${FLUID_DOCS_PATH} ABSOLUTE
    )
  endif()

  FetchContent_GetProperties(flucoma-docs)
  if(NOT flucoma-docs_POPULATED)
    FetchContent_Populate(flucoma-docs)
    file(GLOB_RECURSE DOC_SOURCE RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${flucoma-docs_SOURCE_DIR}/**/*.cpp" )
    source_group("\\XML Doc Gen" FILES ${DOC_SOURCE})
    add_subdirectory(${flucoma-docs_SOURCE_DIR} ${flucoma-docs_BINARY_DIR})
  endif()

  set(MAX_DOC_PATH "${CMAKE_SOURCE_DIR}/docs" CACHE PATH "")
  # add_custom_target(MAX_MAKE_DOCS ALL)
  # add_dependencies(MAX_MAKE_DOCS MAKE_MAX_REF)  
  # add_custom_command(TARGET MAX_MAKE_DOCS POST_BUILD
  #   COMMAND ${CMAKE_COMMAND} -E copy_directory "${FLUID_MAX_REF_PATH}"  "${CMAKE_CURRENT_SOURCE_DIR}/docs"
  #   COMMENT "${MAX_DOC_PATH}"
  # )
endif()

# Misc setup and subroutines
include("${CMAKE_CURRENT_SOURCE_DIR}/source/script/max-package.cmake")

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
set(FLUID_PACKAGE_NAME "Fluid Corpus Manipulation" CACHE STRING "Name for published package")
set(MAX_PACKAGE_ROOT ${MAX_INSTALL_PREFIX}/${FLUID_PACKAGE_NAME})

foreach(PACKAGE_DIRECTORY examples;extras;help;init;patchers;interfaces)
  install(DIRECTORY ${PACKAGE_DIRECTORY} DESTINATION ${MAX_PACKAGE_ROOT})
endforeach(PACKAGE_DIRECTORY)

install(DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/ 
        DESTINATION ${MAX_PACKAGE_ROOT}/externals 
        FILES_MATCHING REGEX "\\.(mxo|mxe|mxe64)")

# install(CODE [[ message(STATUS "${flucoma-core_SOURCE_DIR}") ]])
install(DIRECTORY "${flucoma-core_SOURCE_DIR}/AudioFiles/" 
        DESTINATION "${MAX_PACKAGE_ROOT}/media")
install(FILES icon.png package-info.json QuickStart.md 
        DESTINATION ${MAX_PACKAGE_ROOT})
install(FILES ${flucoma-core_SOURCE_DIR}/distribution.lic 
        DESTINATION ${MAX_PACKAGE_ROOT} 
        RENAME LICENSE.md)

if(DOCS)
  install(DIRECTORY "${MAX_DOC_PATH}/" 
          DESTINATION "${MAX_PACKAGE_ROOT}/docs"  
          PATTERN "*.xml")
endif()
