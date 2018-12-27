set(GOPATH "${CMAKE_CURRENT_LIST_DIR}")

function(ExternalGoProject_Add TARG)
  add_custom_target(${TARG} env GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} get ${ARGN})
endfunction(ExternalGoProject_Add)

function(add_go_executable NAME)
  message("enter ${NAME} ${ARGN}")

  if(WIN32)
    set(EXE_NAME "${NAME}.exe")
  else(WIN32)
    set(EXE_NAME "${NAME}")
  endif(WIN32)

  string(REGEX REPLACE ";"  " " GO_SOURCE_SPACE "${ARGN}")

  set(GO_BUILD_CMD "${CMAKE_Go_COMPILER} build -o ${EXECUTABLE_OUTPUT_PATH}/${EXE_NAME} ${GO_SOURCE_SPACE}")
  
  message("${GO_BUILD_CMD}")

  add_custom_target(${NAME} ALL)
  
  add_custom_command(
    TARGET ${NAME}
    PRE_BUILD
    COMMAND ${CMAKE_Go_COMPILER} build -o ${EXECUTABLE_OUTPUT_PATH}/${EXE_NAME} ${ARGN}
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    DEPENDS ${ARGN})

  install(PROGRAMS ${EXECUTABLE_OUTPUT_PATH}/${EXE_NAME} DESTINATION bin)
  
endfunction(add_go_executable)

function(add_go_library NAME BUILD_TYPE)
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

  file(GLOB GO_SOURCE RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.go")


  message("add_go_library ${NAME} ${GO_SOURCE}") 
  add_custom_command(OUTPUT ${OUTPUT_DIR}/.timestamp
    COMMAND env GOPATH=${GOPATH} ${CMAKE_Go_COMPILER} build ${BUILD_MODE}
    -o "${LIBRARY_OUTPUT_PATH}/${LIB_NAME}"
    ${CMAKE_GO_FLAGS} ${GO_SOURCE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})

  add_custom_target(${NAME} ALL DEPENDS ${OUTPUT_DIR}/.timestamp ${ARGN})

  if(NOT BUILD_TYPE STREQUAL "STATIC")
    install(PROGRAMS ${LIBRARY_OUTPUT_PATH}/${LIB_NAME} DESTINATION bin)
  endif()
endfunction(add_go_library)
