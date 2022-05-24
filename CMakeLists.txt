# Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
# Copyright 2017-2019 University of Huddersfield.
# Licensed under the BSD-3 License.
# See license.md file in the project root for full license information.
# This project has received funding from the European Research Council (ERC)
# under the European Union’s Horizon 2020 research and innovation programme
# (grant agreement No 725899).

cmake_minimum_required(VERSION 3.18)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

################################################################################
# Paths
set(MAX_TARGET_NAMESPACE "" CACHE STRING "Optional namesapce to prepend to targets to prevent collision in superbuilds")
set(MAX_SDK_PATH "" CACHE PATH "Path to the Max SDK")
if(NOT MAX_SDK_PATH)
  message(FATAL_ERROR "Max SDK Path is not set")
endif()

set(FLUID_PATH "" CACHE PATH "Optional path to the Fluid Decomposition repo")

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
project (flucoma-max LANGUAGES C CXX)

set(CMAKE_XCODE_GENERATE_TOP_LEVEL_PROJECT_ONLY ON)
set(AUTHOR_DOMAIN "org.flucoma")
string(TIMESTAMP "%Y" THISYEAR)
set(COPYRIGHT_STRING "Copyright (c) 2017-${THISYEAR} University of Huddersfield")
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/release-packaging")
set(MAX_INSTALL_PREFIX "." CACHE PATH "Prefix for assembling max package")
set(FLUID_PACKAGE_NAME "FluidCorpusManipulation" CACHE STRING "Name for published package")
set(MAX_PACKAGE_ROOT ${MAX_INSTALL_PREFIX}/${FLUID_PACKAGE_NAME})
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/source/script")
################################################################################
# Fetch / link to dependencies
include(FetchContent)

set(FETCHCONTENT_QUIET FALSE)

FetchContent_Declare(
  flucoma-core
  GIT_REPOSITORY https://github.com/flucoma/flucoma-core.git
  GIT_PROGRESS TRUE
  GIT_TAG origin/main
)

FetchContent_Declare(
  flucoma-docs
  GIT_REPOSITORY https://github.com/flucoma/flucoma-docs.git
  GIT_PROGRESS TRUE  
  GIT_TAG origin/main
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
  file(GLOB FLUCOMA_CORE_RESOURCES ${flucoma-core_SOURCE_DIR}/Resources/Data/*.*)
  file(COPY ${FLUCOMA_CORE_RESOURCES} DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/misc)
  include(flucoma_version)
  include(flucoma-buildtools)
  include(flucoma-buildtype)
endif()

set_if_toplevel(VAR CMAKE_LIBRARY_OUTPUT_DIRECTORY
                TOPLEVEL "${CMAKE_CURRENT_SOURCE_DIR}/externals"
                SUPERBUILD "${CMAKE_SOURCE_DIR}/max_externals")

if(DOCS)  
  set(MAX_DOC_OUT "${CMAKE_SOURCE_DIR}/docs" CACHE PATH "")
  
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
    include(FlucomaDocs)
    set(MAX_DOC_OUT "${CMAKE_BINARY_DIR}/max_ref")
    add_ref_target(max "Making Max ref")
  endif()
  # add_custom_target(MAX_MAKE_DOCS ALL DEPENDS MAKE_MAX_REF)
endif()

FetchContent_Declare(
  fluid_waveform
  URL https://github.com/flucoma/fluid.waveform/releases/download/build/fluid.waveform.tar.gz
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
)

if(NOT fluid_waveform_POPULATED)
  FetchContent_Populate(fluid_waveform)
endif() 

################################################################################
# Max Wrapper
add_library( FLUID_MAX INTERFACE )
target_sources(
	FLUID_MAX INTERFACE
	"${CMAKE_CURRENT_SOURCE_DIR}/source/include/FluidMaxWrapper.hpp"
	"${CMAKE_CURRENT_SOURCE_DIR}/source/include/MaxBufferAdaptor.hpp"
)

target_include_directories(FLUID_MAX INTERFACE 
  "${CMAKE_CURRENT_SOURCE_DIR}/source/include"
)

include(MakeMaxSources)
include(SetupMaxSDK)

# generate targets for standalone clients
get_client_group(NONE client_list)
foreach(client ${client_list}) 
  get_core_client_header(${client} header)   
  get_core_client_class(${client} class)   
  generate_max_source(
    CLIENTS ${client} 
    HEADERS ${header} 
    CLASSES ${class} 
  )
endforeach()

#generate target for MANIPULATION group 
get_client_group(MANIPULATION client_list)
foreach(client ${client_list})  
  get_core_client_header(${client} header)  
  get_core_client_class(${client} class)  
  list(APPEND MANIPULATION_CLIENTS ${client})
  list(APPEND MANIPULATION_HEADERS ${header})
  list(APPEND MANIPULATION_CLASSES ${class})
endforeach()

generate_max_source(
  CLIENTS ${MANIPULATION_CLIENTS}
  HEADERS ${MANIPULATION_HEADERS}
  CLASSES ${MANIPULATION_CLASSES}
  FILENAME fluid.libmanipulation 
)

add_max_external(fluid.list2buf "${CMAKE_CURRENT_SOURCE_DIR}/source/projects/fluid.list2buf/fluid.list2buf.cpp")
add_max_external(fluid.buf2list "${CMAKE_CURRENT_SOURCE_DIR}/source/projects/fluid.buf2list/fluid.buf2list.cpp")

#install bits. Max packages bundle Windows and Mac builds together

foreach(PACKAGE_DIRECTORY examples;extras;help;init;patchers;interfaces;javascript;jsui;misc)
  install(DIRECTORY ${PACKAGE_DIRECTORY} DESTINATION ${MAX_PACKAGE_ROOT})
endforeach(PACKAGE_DIRECTORY)

install(DIRECTORY "${flucoma-core_SOURCE_DIR}/Resources/AudioFiles/" 
        DESTINATION ${MAX_PACKAGE_ROOT}/media)
install(DIRECTORY "${flucoma-core_SOURCE_DIR}/Resources/Data/"
        DESTINATION ${MAX_PACKAGE_ROOT}/misc)
install(FILES icon.png package-info.json QuickStart.md 
        DESTINATION ${MAX_PACKAGE_ROOT})
install(FILES ${flucoma-core_SOURCE_DIR}/distribution.lic 
        DESTINATION ${MAX_PACKAGE_ROOT} 
        RENAME LICENSE.md)
if(DOCS)
  install(DIRECTORY "${MAX_DOC_OUT}/" 
          DESTINATION "${MAX_PACKAGE_ROOT}/docs"  
          PATTERN "*.xml")
endif()

install(DIRECTORY "${fluid_waveform_SOURCE_DIR}/" DESTINATION ${MAX_PACKAGE_ROOT})
