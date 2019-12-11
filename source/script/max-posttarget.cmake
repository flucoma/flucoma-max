# Bits of this Copyright (c) 2016, Cycling '74
# Usage of this file and its contents is governed by the MIT License

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_14)

set_target_properties(${PROJECT_NAME} PROPERTIES
    CXX_STANDARD 14
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

target_link_libraries(${PROJECT_NAME}
  PUBLIC
  FLUID_DECOMPOSITION
  # FLUID_MANIP
  FLUID_MAX
)

target_include_directories (
	${PROJECT_NAME}
	PRIVATE
	"${CMAKE_CURRENT_SOURCE_DIR}/../../include"
)

if(MSVC)
  target_compile_options(${PROJECT_NAME} PRIVATE /W3 )
else()
  target_compile_options(${PROJECT_NAME} PRIVATE
    -Wall -Wno-gnu-zero-variadic-macro-arguments -Wextra -Wpedantic -Wreturn-type
      -Wno-conversion -Wno-c++11-narrowing -Wno-sign-compare #quiten it down a bit, until we do a Big IntFix
  )
endif()

target_include_directories( ${PROJECT_NAME}
	SYSTEM PRIVATE
	"${C74_MAX_INCLUDES}"
	"${C74_MSP_INCLUDES}"
	"${C74_JIT_INCLUDES}"
)

get_property(HEADERS TARGET FLUID_DECOMPOSITION PROPERTY INTERFACE_SOURCES)
source_group(TREE "${fluid_decomposition_SOURCE_DIR}/include" FILES ${HEADERS})
get_property(HEADERS TARGET FLUID_MAX PROPERTY INTERFACE_SOURCES)
source_group("Max Wrapper" FILES ${HEADERS})
source_group("" FILES "${PROJECT_NAME}.cpp")
# get_property(HEADERS TARGET FLUID_MANIP PROPERTY INTERFACE_SOURCES)
# source_group(TREE "${fluid_manipulation_SOURCE_DIR}/include" FILES ${HEADERS})

if ("${THIS_FOLDER_NAME}" MATCHES ".*_tilde")
	string(REGEX REPLACE "_tilde" "~" EXTERN_OUTPUT_NAME "${THIS_FOLDER_NAME}")
else ()
    set(EXTERN_OUTPUT_NAME "${THIS_FOLDER_NAME}")
endif ()
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${EXTERN_OUTPUT_NAME}")

if(WIN32)
 target_compile_options(
   ${PROJECT_NAME} PRIVATE $<$<NOT:$<CONFIG:DEBUG>>: /arch:AVX>
 )
else(WIN32)
target_compile_options(
   ${PROJECT_NAME} PRIVATE $<$<NOT:$<CONFIG:DEBUG>>: -mavx>
)
endif(WIN32)

### Output ###
if (APPLE)
	find_library(JITTER_LIBRARY "JitterAPI" HINTS ${C74_MAX_API_DIR})

	target_link_libraries(${PROJECT_NAME} PRIVATE
		"-framework JitterAPI"
		"-framework MaxAudioAPI"
	)

	set_target_properties(${PROJECT_NAME} PROPERTIES
		BUNDLE True
		LINK_FLAGS "-Wl,-F\"${C74_MSP_INCLUDES}\" -F\"${C74_JIT_INCLUDES}\" "
		BUNDLE_EXTENSION "mxo"
		XCODE_ATTRIBUTE_WRAPPER_EXTENSION "mxo"
		MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_LIST_DIR}/Info.plist.in
		MACOSX_BUNDLE_BUNDLE_VERSION "${GIT_VERSION_TAG}"
    XCODE_GENERATE_SCHEME ON
		XCODE_SCHEME_EXECUTABLE "/Applications/Max.app"
    OSX_ARCHITECTURES "x86_64;i386"
    OSX_DEPLOYMENT_TARGET "10.7"
  )
  #If we target 10.7 (actually < 10.9), we have to manually include this:
  target_compile_options(${PROJECT_NAME} PRIVATE -stdlib=libc++)
elseif (WIN32)
	target_compile_options(${PROJECT_NAME} PRIVATE /arch:AVX)
	target_link_libraries(${PROJECT_NAME} PRIVATE ${MaxAPI_LIB})
	target_link_libraries(${PROJECT_NAME} PRIVATE ${MaxAudio_LIB})
	target_link_libraries(${PROJECT_NAME} PRIVATE ${Jitter_LIB})

	if (CMAKE_SIZEOF_VOID_P EQUAL 8)
		set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".mxe64")
	else ()
		set_target_properties(${PROJECT_NAME} PROPERTIES SUFFIX ".mxe")
	endif ()

	# warning about constexpr not being const in c++14
	set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS "/wd4814")

endif ()
