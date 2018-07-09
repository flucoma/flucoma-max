cmake_minimum_required(VERSION 3.0)


include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-pretarget.cmake)


include_directories(
	"${C74_MAX_INCLUDES}"
	"${C74_MSP_INCLUDES}"
)


add_library(
	${PROJECT_NAME}
	MODULE
	${PROJECT_NAME}.cpp
)


include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-posttarget.cmake)
