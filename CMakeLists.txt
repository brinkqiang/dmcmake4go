set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

cmake_minimum_required(VERSION 3.0)

project(dmcmake4go Go)

link_directories(${CMAKE_SOURCE_DIR}/bin)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)
set(LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)

include(cmake/golang.cmake)
include(cmake/flags.cmake)

FILE(GLOB DMCMAKE4GO_SOURCE RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" 
src/dmcmake4go.go
)

add_go_executable(dmcmake4go ${DMCMAKE4GO_SOURCE})
