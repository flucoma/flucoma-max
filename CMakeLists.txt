cmake_minimum_required(VERSION 3.11)
################################################################################
# Paths
set(MAX_SDK_PATH "" CACHE PATH "Path to the Max SDK")
if(NOT MAX_SDK_PATH)
  message(FATAL_ERROR "Max SDK Path is not set")
endif()

set(FLUID_PATH "" CACHE PATH "Optional path to the Fluid Decomposition repo")
# set(FLUID_M_PATH "" CACHE PATH "Optional path to the Fluid fluid_manipulation repo")

option(DOCS "Generate Max XML documentation" OFF)
set(FLUID_PARAMDUMP_PATH "" CACHE PATH "Optional path to fluid_paramdump")

if (APPLE)
	set(CMAKE_OSX_ARCHITECTURES x86_64;i386)
  set(CMAKE_XCODE_GENERATE_SCHEME ON)
  set(CMAKE_XCODE_SCHEME_EXECUTABLE "/Applications/Max.app")
endif()

################################################################################
# Main Action
project (fluid_decomposition_max LANGUAGES CXX)

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

if(FLUID_PATH)
  get_filename_component(
    FETCHCONTENT_SOURCE_DIR_FLUID_DECOMPOSITION ${FLUID_PATH} ABSOLUTE
  )
endif()

FetchContent_GetProperties(fluid_decomposition)
if(NOT fluid_decomposition_POPULATED)
  FetchContent_Populate(fluid_decomposition)
  add_subdirectory(${fluid_decomposition_SOURCE_DIR} ${fluid_decomposition_BINARY_DIR})
endif()


# FetchContent_Declare(
#   fluid_manipulation
#   GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_manipulation.git
#   GIT_PROGRESS TRUE
# )
# if(FLUID_M_PATH)
# get_filename_component(
#   FETCHCONTENT_SOURCE_DIR_FLUID_MANIPULATION ${FLUID_M_PATH} ABSOLUTE
# )
# endif()
# FetchContent_GetProperties(fluid_manipulation)
# if(NOT fluid_manipulation_POPULATED)
#   FetchContent_Populate(fluid_manipulation)
#   add_subdirectory(${fluid_manipulation_SOURCE_DIR} ${fluid_manipulation_BINARY_DIR})
# endif()

if(DOCS)
  FetchContent_Declare(
    fluid_paramdump
    GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_paramdump.git
    GIT_PROGRESS TRUE
  )
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

  add_custom_target(COPY_DOCS DEPENDS MAKE_MAX_REF)
  add_custom_command(
    TARGET COPY_DOCS POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory "${fluid_paramdump_SOURCE_DIR}/maxref" "${CMAKE_CURRENT_SOURCE_DIR}/docs"
  )
endif()

# Misc setup and subroutines
include("${CMAKE_CURRENT_SOURCE_DIR}/source/script/max-package.cmake")

# only on Max do we need UBs
set_property(TARGET HISSTools_FFT PROPERTY OSX_ARCHITECTURES x86_64;i386)

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
		message("Generating: ${project_dir}")
		add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir}")
    source_group("" FILES "${project_dir}.cpp")
	endif ()
endforeach ()

################################################################################
#install bits
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/release-packaging")

foreach(PACKAGE_DIRECTORY docs;examples;extras;help;init;javascript;patchers)
  install(DIRECTORY ${PACKAGE_DIRECTORY} DESTINATION .)
endforeach(PACKAGE_DIRECTORY)
install(DIRECTORY externals DESTINATION . PATTERN "*.ilk" EXCLUDE PATTERN "*.PDB" EXCLUDE)
install(DIRECTORY "${fluid_decomposition_SOURCE_DIR}/AudioFiles/" DESTINATION ./media)
install(FILES License.md icon.png package-info.json QuickStart.md DESTINATION .)
