# Bits of this Copyright (c) 2016, Cycling '74
# Usage of this file and its contents is governed by the MIT License


target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_14)
add_dependencies (${PROJECT_NAME} FLUID_DECOMPOSITION)

target_link_libraries(${PROJECT_NAME}
PUBLIC FLUID_DECOMPOSITION  FLUID_MAX
PRIVATE FFTLIB
)

target_include_directories (
	${PROJECT_NAME}
	PRIVATE
	"${CMAKE_CURRENT_SOURCE_DIR}/../../include"
)

if(MSVC)
  target_compile_options(${PROJECT_NAME} PRIVATE /W4 )
else(MSVC)
  target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Wpedantic -Wreturn-type -Wconversion)
endif()

target_include_directories( ${PROJECT_NAME}
	SYSTEM PRIVATE
	"${C74_MAX_INCLUDES}"
	"${C74_MSP_INCLUDES}"
	"${C74_JIT_INCLUDES}"
)

get_property(HEADERS TARGET FLUID_DECOMPOSITION PROPERTY INTERFACE_SOURCES)
source_group(TREE "${FLUID_PATH}/include" FILES ${HEADERS})

if ("${PROJECT_NAME}" MATCHES ".*_tilde")
	string(REGEX REPLACE "_tilde" "~" EXTERN_OUTPUT_NAME "${PROJECT_NAME}")
else ()
    set(EXTERN_OUTPUT_NAME "${PROJECT_NAME}")
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
		XCODE_SCHEME_EXECUTABLE "/Applications/Max.app"
)
	#
	# set_property(TARGET ${PROJECT_NAME}
	# 			 PROPERTY )
	# set_property(TARGET ${PROJECT_NAME}
	# 			 PROPERTY )
	# set_target_properties(${PROJECT_NAME}
	# set_target_properties(${PROJECT_NAME} PROPERTIES )
	# set_target_properties(${PROJECT_NAME} PROPERTIES )
	#
  #   set_target_properties(${PROJECT_NAME} PROPERTIES )
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


### Post Build ###
#if (WIN32)
#	add_custom_command(
#		TARGET ${PROJECT_NAME}
#		POST_BUILD
#		COMMAND rm "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${EXTERN_OUTPUT_NAME}.ilk"
#		COMMENT "ilk file cleanup"
#)
# endif ()
