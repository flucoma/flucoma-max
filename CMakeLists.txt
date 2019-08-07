cmake_minimum_required(VERSION 3.3)

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

if(APPLE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Wno-gnu-zero-variadic-macro-arguments")
endif()

# Misc setup and subroutines
include("${CMAKE_CURRENT_SOURCE_DIR}/source/script/max-package.cmake")

set(FLUID_PATH ~/fluid_decomposition CACHE PATH "The top level of the fluid_decomposition repo")
set(FLUID_M_PATH ~/dev/fluid_manipulation/fluid_manipulation CACHE PATH "The top level of the fluid_decomposition repo")

get_filename_component(FLUID_ABS_PATH ${FLUID_PATH} ABSOLUTE)
message(${FLUID_ABS_PATH})
# if (NOT DEFINED ${FLUID_DECOMP_PATH})
# 	message(FATAL_ERROR "Please set the path to the fluid_decomposition sources with -DFLUID_DECOMP_PATH=<path>")
# endif()

if (NOT (EXISTS "${FLUID_ABS_PATH}/build/fluid_decomposition-exports.cmake"))
	message(FATAL_ERROR "Can't find the fluid_decomposition CMake targets file at ${FLUID_ABS_PATH}/build/fluid_decomposition-exports.cmake. Please go to ${FLUID_ABS_PATH}/build and run CMake")
endif()


if (NOT (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/media/"))
	file(MAKE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/media/")
endif()

file(COPY "${FLUID_ABS_PATH}/AudioFiles/" DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/media/")
include("${FLUID_ABS_PATH}/build/fluid_decomposition-exports.cmake")


get_property(FFT_SOURCES TARGET HISSTools_FFT  PROPERTY INTERFACE_SOURCES)
get_property(FFT_LINK TARGET HISSTools_FFT  PROPERTY INTERFACE_LINK_LIBRARIES)

add_library(FFTLIB STATIC ${FFT_SOURCES})
target_link_libraries(
  FFTLIB PRIVATE ${FFT_LINK}
)

if(WIN32)
 target_compile_options(
   FFTLIB PRIVATE $<$<NOT:$<CONFIG:DEBUG>>: /arch:AVX>
 )
else(WIN32)
target_compile_options(
   FFTLIB PRIVATE $<$<NOT:$<CONFIG:DEBUG>>: -mavx>
)
endif(WIN32)

set_property(TARGET FFTLIB PROPERTY OSX_ARCHITECTURES x86_64;i386)

# target_compile_options(FFTLIB PRIVATE -Wall -Wextra -Wpedantic -Wreturn-type -Wconversion)

add_library( FLUID_MAX INTERFACE )
target_sources(
	FLUID_MAX INTERFACE
	"${CMAKE_CURRENT_SOURCE_DIR}/source/include/FluidMaxWrapper.hpp"
	"${CMAKE_CURRENT_SOURCE_DIR}/source/include/MaxBufferAdaptor.hpp"
)



# Make sure to build targets from fluid_decomposition
# add_subdirectory(${FLUID_ABS_PATH} ${FLUID_ABS_PATH}/build)

# Generate a project for every folder in the "source/projects" folder
SUBDIRLIST(PROJECT_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/source/projects")
foreach (project_dir ${PROJECT_DIRS})
	if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir}/CMakeLists.txt")
		message("Generating: ${project_dir}")
		add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/source/projects/${project_dir}")
	endif ()
endforeach ()
