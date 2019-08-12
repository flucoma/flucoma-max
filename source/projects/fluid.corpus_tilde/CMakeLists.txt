cmake_minimum_required(VERSION 3.3)

include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-pretarget.cmake)

add_library(
	${PROJECT_NAME}
	MODULE
	${PROJECT_NAME}.cpp
)

include(${CMAKE_CURRENT_SOURCE_DIR}/../../script/max-posttarget.cmake)
