cmake_minimum_required(VERSION 3.11)

if (APPLE)
	set(CMAKE_OSX_ARCHITECTURES x86_64;i386)
endif()

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_EXTENSIONS OFF)
# set(CMAKE_NO_SYSTEM_FROM_IMPORTED ON)


if(APPLE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mavx")

# We shouldn't have to do this, bah:
#TODO find way of guranteeing libc++ on OS X CLI (hence >=C++11) without brute forcing CMake like this
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -stdlib=libc++ -lc++abi")

set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.7" CACHE STRING "Minimum OS X deployment version")
set(CMAKE_XCODE_GENERATE_SCHEME ON)
endif()

if(WIN32)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++14")
endif()


# set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Fetch the correct verion of the max-api
#message(STATUS "Updating Git Submodules")
#execute_process(
#	COMMAND				git submodule update --init --recursive
#	WORKING_DIRECTORY	"${CMAKE_CURRENT_SOURCE_DIR}"
#)
project (fluid_decomposition_max LANGUAGES CXX)

include(FetchContent)

set(FETCHCONTENT_QUIET FALSE)

if(DEFINED FLUID_PATH)
get_filename_component(FLUID_PATH ${FLUID_PATH} ABSOLUTE)
message(${FLUID_PATH})
FetchContent_Declare(
  fluid_decomposition
  # URL ${FLUID_PATH}
  DOWNLOAD_COMMAND ""
  SOURCE_DIR "${FLUID_PATH}/"
)
else()
FetchContent_Declare(
  fluid_decomposition
  GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_decomposition.git
  GIT_PROGRESS TRUE
)
endif()

# if(DEFINED FLUID_M_PATH)
# get_filename_component(FLUID_M_PATH ${FLUID_M_PATH} ABSOLUTE)
# FetchContent_Declare(
#   fluid_manipulation
#   # URL ${FLUID_M_PATH}
#   DOWNLOAD_COMMAND ""
#   SOURCE_DIR "${FLUID_M_PATH}/"
# )
# else()
# FetchContent_Declare(
#   fluid_manipulation
#   GIT_REPOSITORY https://bitbucket.org/flucoma/fluid_manipulation.git
#   GIT_PROGRESS TRUE
# )
# endif()

FetchContent_GetProperties(fluid_decomposition)
if(NOT fluid_decomposition_POPULATED)
  FetchContent_Populate(fluid_decomposition)
  add_subdirectory(${fluid_decomposition_SOURCE_DIR} ${fluid_decomposition_BINARY_DIR})
endif()

# FetchContent_GetProperties(fluid_manipulation)
# if(NOT fluid_manipulation_POPULATED)
#   FetchContent_Populate(fluid_manipulation)
#   add_subdirectory(${fluid_manipulation_SOURCE_DIR} ${fluid_manipulation_BINARY_DIR})
# endif()

if(APPLE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Wno-gnu-zero-variadic-macro-arguments")
endif()

# Misc setup and subroutines
include("${CMAKE_CURRENT_SOURCE_DIR}/source/script/max-package.cmake")

set_property(TARGET HISSTools_FFT PROPERTY OSX_ARCHITECTURES x86_64;i386)

add_library( FLUID_MAX INTERFACE )
target_sources(
	FLUID_MAX INTERFACE
	"${CMAKE_CURRENT_SOURCE_DIR}/source/include/FluidMaxWrapper.hpp"
	"${CMAKE_CURRENT_SOURCE_DIR}/source/include/MaxBufferAdaptor.hpp"
)

# Make sure to build targets from fluid_decomposition
# add_subdirectory(${FLUID_ABS_PATH} ${FLUID_ABS_PATH}/build)
set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/release-packaging")
#install bits
foreach(PACKAGE_DIRECTORY docs;examples;externals;extras;help;init;javascript;patchers)
  install(DIRECTORY ${PACKAGE_DIRECTORY} DESTINATION .)
endforeach(PACKAGE_DIRECTORY)
install(DIRECTORY "${fluid_decomposition_SOURCE_DIR}/AudioFiles/" DESTINATION ./media)
install(FILES License.md icon.png package-info.json QuickStart.md DESTINATION .)

# Generate a project for every folder in the "source/projects" folder
SUBDIRLIST(PROJECT_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/source/projects")
foreach (project_dir ${PROJECT_DIRS})
	if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir}/CMakeLists.txt")
		message("Generating: ${project_dir}")
		add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir}")
	endif ()
endforeach ()
