set(GOPATH "${CMAKE_SOURCE_DIR}")

function(ExternalGoProject_Add TARG)
  add_custom_target(${TARG} env GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} get ${ARGN})
endfunction(ExternalGoProject_Add)

function(add_go_executable NAME)
  message("enter ${GOPATH} ${NAME} ${ARGN}")

  if(WIN32)
    set(EXE_NAME "${NAME}.exe")
  else(WIN32)
    set(EXE_NAME "${NAME}")
  endif(WIN32)

  string(REGEX REPLACE ";"  " " GO_SOURCE_SPACE "${ARGN}")

  set(GO_BUILD_CMD "env GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} build -o ${EXECUTABLE_OUTPUT_PATH}/${EXE_NAME} ${GO_SOURCE_SPACE}")
  
  message("${GO_BUILD_CMD}")

  add_custom_target(${NAME} ALL)
  
  add_custom_command(
    TARGET ${NAME}
    PRE_BUILD
    COMMAND env GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} build -o ${EXECUTABLE_OUTPUT_PATH}/${EXE_NAME} ${ARGN}
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    DEPENDS ${ARGN})

  install(PROGRAMS ${EXECUTABLE_OUTPUT_PATH}/${EXE_NAME} DESTINATION bin)
  
endfunction(add_go_executable)

function(add_go_library NAME BUILD_TYPE)
  message("enter ${NAME} ${BUILD_TYPE} ${ARGN}")
  if(BUILD_TYPE STREQUAL "STATIC")
    set(BUILD_MODE -buildmode=c-archive)
    set(LIB_NAME "lib${NAME}.a")

  else()
    set(BUILD_MODE -buildmode=c-shared)
    if(APPLE)
      set(LIB_NAME "lib${NAME}.dylib")
    else()
      set(LIB_NAME "lib${NAME}.so")
    endif()
  endif()

  add_custom_target(${NAME} ALL)
  
  message("${CMAKE_Go_COMPILER} build ${BUILD_MODE} -o ${EXECUTABLE_OUTPUT_PATH}/${LIB_NAME} ${ARGN}")
  add_custom_command(
    TARGET ${NAME}
    PRE_BUILD
    COMMAND env GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} build ${BUILD_MODE} -o ${EXECUTABLE_OUTPUT_PATH}/${LIB_NAME} ${ARGN}
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    DEPENDS ${ARGN})

  if(NOT BUILD_TYPE STREQUAL "STATIC")
    install(PROGRAMS ${LIBRARY_OUTPUT_PATH}/${LIB_NAME} DESTINATION bin)
  endif()
endfunction(add_go_library)
