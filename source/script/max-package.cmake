# Copyright (c) 2016, Cycling '74
# Usage of this file and its contents is governed by the MIT License

string(REGEX REPLACE "(.*)/" "" THIS_FOLDER_NAME "${CMAKE_CURRENT_SOURCE_DIR}")
project(${THIS_FOLDER_NAME})


# Set version variables based on the current Git tag
include("${CMAKE_CURRENT_LIST_DIR}/git-rev.cmake")

# Update package-info.json, if present
if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/package-info.json.in")
	message("Building _____ ${GIT_TAG} _____")
	set(C74_PACKAGE_NAME "${THIS_FOLDER_NAME}")
	configure_file("${CMAKE_CURRENT_SOURCE_DIR}/package-info.json.in" "${CMAKE_CURRENT_SOURCE_DIR}/package-info.json" @ONLY)

	message("Reading ${CMAKE_CURRENT_SOURCE_DIR}/package-info.json")
	file(READ "${CMAKE_CURRENT_SOURCE_DIR}/package-info.json" PKGINFOFILE)
endif ()


# Update Info.plist files on the Mac
if (APPLE)
	message("Generating Info.plist")

	if (NOT DEFINED AUTHOR_DOMAIN)
		set(AUTHOR_DOMAIN "com.acme")
	endif ()
	if (NOT DEFINED COPYRIGHT_STRING)
		set(COPYRIGHT_STRING "Copyright (c) 1974 Acme Inc")
	endif ()
	if (NOT DEFINED EXCLUDE_FROM_COLLECTIVES)
		set(EXCLUDE_FROM_COLLECTIVES "no")
	endif()

	set(BUNDLE_IDENTIFIER "\${PRODUCT_NAME:rfc1034identifier}")
	configure_file("${CMAKE_CURRENT_LIST_DIR}/Info.plist.in" "${CMAKE_CURRENT_LIST_DIR}/Info.plist" @ONLY)
endif ()


# Macro from http://stackoverflow.com/questions/7787823/cmake-how-to-get-the-name-of-all-subdirectories-of-a-directory
MACRO(SUBDIRLIST result curdir)
  FILE(GLOB children RELATIVE ${curdir} ${curdir}/*)
  SET(dirlist "")
  FOREACH(child ${children})
    IF(IS_DIRECTORY ${curdir}/${child})
        LIST(APPEND dirlist ${child})
    ENDIF()
  ENDFOREACH()
  SET(${result} ${dirlist})
ENDMACRO()
