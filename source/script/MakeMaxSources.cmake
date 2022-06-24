# Part of the Fluid Corpus Manipulation Project (http://www.flucoma.org/)
# Copyright 2017-2019 University of Huddersfield.
# Licensed under the BSD-3 License.
# See license.md file in the project root for full license information.
# This project has received funding from the European Research Council (ERC)
# under the European Union’s Horizon 2020 research and innovation programme
# (grant agreement No 725899).

include(FluidClientStub)

function(make_external_name client header var)  
  string(FIND ${header} "clients/rt" is_rtclient)
  string(FIND ${client}  "Buf" is_bufclient)  
  string(TOLOWER ${client} lc_client) 
  string(PREPEND lc_client "fluid.")
  
  get_property(NO_TILDE GLOBAL PROPERTY FLUID_CORE_CLIENTS_${client}_KR_IN SET)
  
  if(NOT NO_TILDE)
    string(APPEND lc_client "~")
  endif()

  set(${var} ${lc_client} PARENT_SCOPE)
endfunction()

function(pr_generate_includes headers var) 
  foreach(h ${headers})
    string(APPEND include_block "#include <${h}>\n")
  endforeach()
  set(${var} ${include_block} PARENT_SCOPE)
endfunction() 

function(pr_generate_makeclass clients headers classes template var externals_out)
  foreach(client header class IN ZIP_LISTS clients headers classes)
    make_external_name(${client} ${header} external)
    list(APPEND externals ${external})
    string(CONFIGURE "${template}" make_class)
    string(APPEND make_class_block "  ${make_class}\n")    
  endforeach() 
  set(${var} ${make_class_block} PARENT_SCOPE)  
  set(${externals_out} ${externals} PARENT_SCOPE)
endfunction()


function(generate_max_source)  
  # # Define the supported set of keywords
  set(noValues "")
  set(singleValues FILENAME EXTERNALS_OUT FILE_OUT)
  set(multiValues CLIENTS HEADERS CLASSES)
  # # Process the arguments passed in
  include(CMakeParseArguments)
  cmake_parse_arguments(ARG
  "${noValues}"
  "${singleValues}"
  "${multiValues}"
  ${ARGN})  
  
  set(WRAPPER_TEMPLATE [=[makeMaxWrapper<${class}>("${external}");]=])
  set(ENTRY_POINT "void ext_main(void*)")
  set(CCE_WRAPPER "#include \"FluidMaxWrapper.hpp\" //nb: this include is order-sensitive because of macro name clashes in Eigen and C74")
  generate_source(${ARGN} EXTERNALS_OUT external FILE_OUT outfile)
  
  if(ARG_FILENAME)
    set(external_filename ${ARG_FILENAME})
  else()
    list(GET external 0 external_filename)    
  endif()

  set(INSTALLFLAG "")
  if(ARG_CLIENTS AND NOT ARG_FILENAME)
    list(GET ARG_CLIENTS 0 client)    
    get_property(no_install GLOBAL PROPERTY FLUID_CORE_CLIENTS_${client}_INSTALL)
    if(no_install) 
      set(INSTALLFLAG NOINSTALL)
    endif()
  endif()
  
  message(STATUS "Generating: ${external_filename}")
  add_max_external(${external_filename} ${outfile} ${INSTALLFLAG})
endfunction()
