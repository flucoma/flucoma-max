cmake_minimum_required(VERSION 3.0)


include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-pretarget.cmake)

set(EIGENMF_DIR ~/eigenmf)

include_directories( 
	"${C74_MAX_INCLUDES}"
	"${C74_MSP_INCLUDES}"
	"${C74_JIT_INCLUDES}"
	"${EIGENMF_DIR}"
        "${EIGENMF_DIR}/Eigen"
        "${EIGENMF_DIR}/HISSTools_FFT"
)


add_library( 
	${PROJECT_NAME} 
	MODULE
	${PROJECT_NAME}.cc
	"${EIGENMF_DIR}/nmf.cc"
	"${EIGENMF_DIR}/nmf.h"
	"${EIGENMF_DIR}/stft.cc"
	"${EIGENMF_DIR}/stft.h"
        "${EIGENMF_DIR}/HISSTools_FFT/HISSTools_FFT.cpp"
)


if(APPLE) 
	target_link_libraries(${PROJECT_NAME} "-framework Accelerate") 
endif ()


include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-posttarget.cmake)
