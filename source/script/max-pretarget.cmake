# Copyright (c) 2016, Cycling '74
# Usage of this file and its contents is governed by the MIT License

string(REGEX REPLACE "(.*)/" "" THIS_FOLDER_NAME "${CMAKE_CURRENT_SOURCE_DIR}")

project(${MAX_TARGET_NAMESPACE}${THIS_FOLDER_NAME})

if(MSVC)
  foreach(flag_var
      CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
      CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    if(${flag_var} MATCHES "/MD")
      string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
    endif()
  endforeach()
endif()

if (NOT DEFINED C74_MAX_API_DIR)
   file(TO_CMAKE_PATH "${MAX_SDK_PATH}" MAX_SDK_FULLPATH)
   if(EXISTS "${MAX_SDK_FULLPATH}/source/c74support")
     set(C74_MAX_API_DIR "${MAX_SDK_FULLPATH}/source/c74support")
   # newer SDK layout, full Max-SDK download 
   elseif(EXISTS "${MAX_SDK_FULLPATH}/source/max-sdk-base/c74support") 
     set(C74_MAX_API_DIR "${MAX_SDK_FULLPATH}/source/max-sdk-base/c74support")
    # newer SDK layout, just max-sdk-base   
   elseif(EXISTS "${MAX_SDK_FULLPATH}/c74support")   
      set(C74_MAX_API_DIR "${MAX_SDK_FULLPATH}/74support")
   else()
     message(FATAL_ERROR "Could not find Cycling 74 support folder")
   endif()
endif ()
#set(C74_INCLUDES "${C74_MAX_API_DIR}/include")
set(C74_MAX_INCLUDES ${C74_MAX_API_DIR}/max-includes)
set(C74_MSP_INCLUDES ${C74_MAX_API_DIR}/msp-includes)
set(C74_JIT_INCLUDES ${C74_MAX_API_DIR}/jit-includes)

set(C74_SCRIPTS "../../script")

set(C74_CXX_STANDARD 0)


# if (NOT DEFINED C74_BUILD_MAX_EXTENSION)
# 	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../../externals")
# else ()
# 	set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../../extensions")
# endif ()
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_TEST "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")

if (WIN32)

	set(CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/tmp")
	set(CMAKE_PDB_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/tmp")

	if (CMAKE_SIZEOF_VOID_P EQUAL 8)
		SET(MaxAPI_LIB ${C74_MAX_INCLUDES}/x64/MaxAPI.lib)
		SET(MaxAudio_LIB ${C74_MSP_INCLUDES}/x64/MaxAudio.lib)
		SET(Jitter_LIB ${C74_JIT_INCLUDES}/x64/jitlib.lib)
	else ()
		SET(MaxAPI_LIB ${C74_MAX_INCLUDES}/MaxAPI.lib)
		SET(MaxAudio_LIB ${C74_MSP_INCLUDES}/MaxAudio.lib)
		SET(Jitter_LIB ${C74_JIT_INCLUDES}/jitlib.lib)
	endif ()

	MARK_AS_ADVANCED (MaxAPI_LIB)
	MARK_AS_ADVANCED (MaxAudio_LIB)
	MARK_AS_ADVANCED (Jitter_LIB)

	add_definitions(
		-DMAXAPI_USE_MSCRT
		-DWIN_VERSION
		-D_USE_MATH_DEFINES
	)
else ()
	#file (STRINGS "${C74_MAX_API_DIR}/script/max-linker-flags.txt" C74_SYM_MAX_LINKER_FLAGS)
	#file (STRINGS "${C74_MAX_API_DIR}/script/msp-linker-flags.txt" C74_SYM_MSP_LINKER_FLAGS)
	file (STRINGS "${C74_MAX_INCLUDES}/c74_linker_flags.txt" C74_SYM_LINKER_FLAGS)


	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${C74_SYM_LINKER_FLAGS}")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${C74_SYM_LINKER_FLAGS}")
	set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${C74_SYM_LINKER_FLAGS}")
endif ()
