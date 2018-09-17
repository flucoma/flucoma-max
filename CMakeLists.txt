cmake_minimum_required(VERSION 3.3)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 11)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++ -mavx -msse -msse2 -msse3 -msse4")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -stdlib=libc++")
SET(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.7" CACHE STRING "Minimum OS X deployment version")


# Fetch the correct verion of the max-api
#message(STATUS "Updating Git Submodules")
#execute_process(
#	COMMAND				git submodule update --init --recursive
#	WORKING_DIRECTORY	"${CMAKE_CURRENT_SOURCE_DIR}"
#)
project (fluid_decomposition_max LANGUAGES CXX)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic")

# Misc setup and subroutines
include(${CMAKE_CURRENT_SOURCE_DIR}/source/script/max-package.cmake)

set(FLUID_PATH ~/fluid_decomposition CACHE PATH "The top level of the fluid_decomposition repo")

get_filename_component(FLUID_ABS_PATH ${FLUID_PATH} ABSOLUTE)
message(${FLUID_ABS_PATH})
# if (NOT DEFINED ${FLUID_DECOMP_PATH})
# 	message(FATAL_ERROR "Please set the path to the fluid_decomposition sources with -DFLUID_DECOMP_PATH=<path>")
# endif()

if (NOT (EXISTS "${FLUID_ABS_PATH}/build/fluid_decomposition-exports.cmake"))
	message(FATAL_ERROR "Can't find the fluid_decomposition CMake targets file at ${FLUID_ABS_PATH}/build/fluid_decomposition-expors.cmake. Please go to ${FLUID_ABS_PATH}/build and run CMake")
endif()


if (NOT (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/media/))
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/media/)
endif()

file(COPY ${FLUID_ABS_PATH}/AudioFiles/ DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/media/)


include("${FLUID_ABS_PATH}/build/fluid_decomposition-exports.cmake")

# Generate a project for every folder in the "source/projects" folder
SUBDIRLIST(PROJECT_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/source/projects)
foreach (project_dir ${PROJECT_DIRS})
	if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir}/CMakeLists.txt")
		message("Generating: ${project_dir}")
		add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir})
	endif ()
endforeach ()
