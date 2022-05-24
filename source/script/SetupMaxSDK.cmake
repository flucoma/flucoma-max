# Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
# Copyright 2017-2019 University of Huddersfield.
# Licensed under the BSD-3 License.
# See license.md file in the project root for full license information.
# This project has received funding from the European Research Council (ERC)
# under the European Union’s Horizon 2020 research and innovation programme
# (grant agreement No 725899).

include_guard() 

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
      set(C74_MAX_API_DIR "${MAX_SDK_FULLPATH}/c74support")
   else()
     message(FATAL_ERROR "Could not find Cycling 74 support folder")
   endif()
endif ()

set(C74_MAX_INCLUDES ${C74_MAX_API_DIR}/max-includes)
set(C74_MSP_INCLUDES ${C74_MAX_API_DIR}/msp-includes)
set(C74_JIT_INCLUDES ${C74_MAX_API_DIR}/jit-includes)

set(FLUID_MAX_SCRIPTS "${CMAKE_CURRENT_LIST_DIR}")

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
	file (STRINGS "${C74_MAX_INCLUDES}/c74_linker_flags.txt" C74_SYM_LINKER_FLAGS)
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${C74_SYM_LINKER_FLAGS}")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${C74_SYM_LINKER_FLAGS}")
	set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} ${C74_SYM_LINKER_FLAGS}")
endif ()

add_library(MAX_SDK OBJECT
  "${C74_MAX_INCLUDES}/common/commonsyms.c"
)
set_target_properties(MAX_SDK PROPERTIES LINKER_LANGUAGE C)

target_include_directories(MAX_SDK SYSTEM PUBLIC 
  "${C74_MAX_INCLUDES}"
  "${C74_MSP_INCLUDES}"
  "${C74_JIT_INCLUDES}"
)

if (APPLE)
  find_library(JITTER_LIBRARY "JitterAPI" HINTS  "${C74_MSP_INCLUDES}")
  find_library(MAX_AUDIO_API "MaxAudioAPI" HINTS "${C74_JIT_INCLUDES}")

  target_link_libraries(MAX_SDK PUBLIC
    ${JITTER_LIBRARY}
    ${MAX_AUDIO_API}
  )
elseif (WIN32)    
  target_link_libraries(MAX_SDK PUBLIC "${MaxAPI_LIB}")
  target_link_libraries(MAX_SDK PUBLIC "${MaxAudio_LIB}")
  target_link_libraries(MAX_SDK PUBLIC "${Jitter_LIB}")
endif ()

function(add_max_external)
  
  # Define the supported set of keywords
  set(noValues NOINSTALL)
  set(singleValues "")
  set(multiValues "")
  # Process the arguments passed in
  include(CMakeParseArguments)
  cmake_parse_arguments(ARG
  "${noValues}"
  "${singleValues}"
  "${multiValues}"
  ${ARGN})  

  list(LENGTH ARG_UNPARSED_ARGUMENTS NUM_PLAIN_ARGS)
    
  if(NUM_PLAIN_ARGS LESS 2)
    message(FATAL_ERROR "add_max_external called without arguments for object name and source file")
  endif() 
  
  list(GET ARG_UNPARSED_ARGUMENTS 0 name)
  list(GET ARG_UNPARSED_ARGUMENTS 1 source)
    
  string(REGEX REPLACE "~" "_tilde" safe_name ${name})
  
  add_library(${safe_name} MODULE ${source})
  
  if(NOT EXISTS "${C74_MAX_API_DIR}/max-includes/common/commonsyms.c")
    message(FATAL_ERROR "NOOOOOOOOO")
  endif()
  
  set_target_properties(${safe_name} PROPERTIES OUTPUT_NAME "${name}")
  
  # target_sources(${safe_name} PRIVATE 
  #   "${C74_MAX_INCLUDES}/common/commonsyms.c"
  # )
  # message(FATAL_ERROR "${C74_MAX_API_DIR}/max-includes/common/commonsyms.c")

  target_link_libraries(${safe_name}
    PRIVATE
    FLUID_DECOMPOSITION
    FLUID_MAX
    MAX_SDK
  )

  target_include_directories (
  	${safe_name}
  	PRIVATE
  	"${CMAKE_CURRENT_SOURCE_DIR}/source/include"
  )

  if(MSVC)
    target_compile_options(${safe_name} PRIVATE /external:W0 /W3)
  else()
    target_compile_options(${safe_name} PRIVATE
      -Wall -Wno-gnu-zero-variadic-macro-arguments -Wextra -Wpedantic -Wreturn-type -include "${C74_MAX_INCLUDES}/macho-prefix.pch"
    )
  endif()

  # target_include_directories( ${safe_name}
  # 	SYSTEM PRIVATE
  # 	"${C74_MAX_INCLUDES}"
  # 	"${C74_MSP_INCLUDES}"
  # 	"${C74_JIT_INCLUDES}"
  # )

  get_property(HEADERS TARGET FLUID_DECOMPOSITION PROPERTY INTERFACE_SOURCES)
  source_group(TREE "${flucoma-core_SOURCE_DIR}/include" FILES ${HEADERS})
  get_property(HEADERS TARGET FLUID_MAX PROPERTY INTERFACE_SOURCES)
  source_group("Max Wrapper" FILES ${HEADERS})
  source_group("" FILES "${source}")

  #set AVX or whatever
  if(DEFINED FLUID_ARCH)
    target_compile_options(${safe_name} PRIVATE ${FLUID_ARCH})
  endif()

  ### Output ###
  if (APPLE)
    
  	# find_library(JITTER_LIBRARY "JitterAPI" HINTS "${C74_MAX_API_DIR}/jit-includes")
    # find_library(MAX_AUDIO_API "MaxAudioAPI" HINTS "${C74_MAX_API_DIR}/msp-includes")
    # 
  	# target_link_libraries(${safe_name} PRIVATE
  	# 	${JITTER_LIBRARY}
  	# 	${MAX_AUDIO_API}
  	# )
        
    get_property(VERSION_TAG GLOBAL PROPERTY FLUCOMA_VERSION_TERSE)
    
    if (NOT DEFINED EXCLUDE_FROM_COLLECTIVES)
		  set(EXCLUDE_FROM_COLLECTIVES no)
	  endif()
    
  	set_target_properties(${safe_name} PROPERTIES
  		BUNDLE True
  		BUNDLE_EXTENSION "mxo"
  		XCODE_ATTRIBUTE_WRAPPER_EXTENSION "mxo"
  		MACOSX_BUNDLE_INFO_PLIST ${FLUID_MAX_SCRIPTS}/Info.plist.in
  		MACOSX_BUNDLE_BUNDLE_VERSION ${VERSION_TAG}
      MACOSX_BUNDLE_SHORT_VERSION_STRING ${VERSION_TAG}
      MACOSX_BUNDLE_EXECUTABLE_NAME ${safe_name}
      MACOSX_BUNDLE_GUI_IDENTIFIER  "org.flucoma.${safe_name}"
      XCODE_GENERATE_SCHEME ON
  		XCODE_SCHEME_EXECUTABLE "/Applications/Max.app"    
    )
      
    #If we target < 10.9 we have to manually include this:
    target_compile_options(${safe_name} PRIVATE -stdlib=libc++)
  elseif (WIN32)
      
  	# target_link_libraries(${safe_name} PRIVATE "${MaxAPI_LIB}")
  	# target_link_libraries(${safe_name} PRIVATE "${MaxAudio_LIB}")
  	# target_link_libraries(${safe_name} PRIVATE "${Jitter_LIB}")
    # message(WARNING "${MaxAPI_LIB}")
  	if (CMAKE_SIZEOF_VOID_P EQUAL 8)
  		set_target_properties(${safe_name} PROPERTIES SUFFIX ".mxe64")
  	else ()
  		set_target_properties(${safe_name} PROPERTIES SUFFIX ".mxe")
  	endif ()

  	# warning about constexpr not being const in c++14
  	set_target_properties(${safe_name} PROPERTIES COMPILE_FLAGS "/wd4814")

  endif ()
  
  if(NOT ARG_NOINSTALL)    
    install(
      TARGETS ${safe_name} 
      LIBRARY DESTINATION ${MAX_PACKAGE_ROOT}/externals
      RUNTIME DESTINATION ${MAX_PACKAGE_ROOT}/externals
      BUNDLE DESTINATION ${MAX_PACKAGE_ROOT}/externals
    )
  endif() 
  
endfunction() 
