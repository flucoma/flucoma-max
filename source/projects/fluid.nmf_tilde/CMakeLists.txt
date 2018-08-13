cmake_minimum_required(VERSION 3.0)


include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-pretarget.cmake)

set(FLUID_DECOMP_DIR ~/fluid_decomposition)

include_directories(
	"${C74_MAX_INCLUDES}"
	"${C74_MSP_INCLUDES}"
	"${C74_JIT_INCLUDES}"
	"${FLUID_DECOMP_DIR}/include"
        "${FLUID_DECOMP_DIR}/3rdparty"      
)


add_library(
	${PROJECT_NAME}
	MODULE
	${PROJECT_NAME}.cc
	"fluid_client_nmf.cc"
	MaxBufferAdaptor.cpp
)


if(APPLE)
	target_link_libraries(${PROJECT_NAME} "-framework Accelerate")
endif ()


include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-posttarget.cmake)
