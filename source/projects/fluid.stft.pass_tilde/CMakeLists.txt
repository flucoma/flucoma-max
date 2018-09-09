cmake_minimum_required(VERSION 3.3)


include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-pretarget.cmake)

# set(FLUID_DECOMP_DIR ~/fluid_decomposition)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
add_library(
	${PROJECT_NAME}
	MODULE
	${PROJECT_NAME}.cpp
	# "${FLUID_DECOMP_DIR}/include/clients/rt/BaseAudioClient.hpp"
	# "${FLUID_DECOMP_DIR}/include/clients/rt/BaseSTFTClient.hpp"
	# "${FLUID_DECOMP_DIR}/3rdparty/HISSTools_FFT/HISSTools_FFT.cpp"
)
target_link_libraries(
	${PROJECT_NAME} FLUID_DECOMPOSITION
)
target_include_directories(
	${PROJECT_NAME}
	PRIVATE
	"${C74_MAX_INCLUDES}"
	"${C74_MSP_INCLUDES}"
	"${C74_JIT_INCLUDES}"
	# "${FLUID_DECOMP_DIR}/include"
	# "${FLUID_DECOMP_DIR}/3rdparty"
)

#
# if(APPLE)
# 	target_link_libraries(${PROJECT_NAME} "-framework Accelerate")
# endif ()


include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-posttarget.cmake)
