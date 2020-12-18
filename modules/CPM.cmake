include_guard(GLOBAL)

include(Ping)

include(Messages)

macro(cpm)
  cmake_parse_arguments(CPM "" "VERSION" "" "${ARGN}")

  if(NOT DEFINED CPM_VERSION)
    set(CPM_VERSION "0.27.6")
  endif()

  set(CPM_DOWNLOAD_LOCATION "${CMAKE_BINARY_DIR}/cmake/CPM_${CPM_VERSION}.cmake")

  if(NOT (EXISTS ${CPM_DOWNLOAD_LOCATION}))
    message(NOTE "Downloading CPM to ${CPM_DOWNLOAD_LOCATION}")
    file(DOWNLOAD https://github.com/flagarde/CPM/releases/download/v${CPM_VERSION}/CPM.cmake ${CPM_DOWNLOAD_LOCATION})
  endif()
  include(${CPM_DOWNLOAD_LOCATION})
endmacro()

function(declare_option)
  cmake_parse_arguments(OPTION "" "REPOSITORY;OPTION;VALUE" "" ${ARGN})
  if(NOT DEFINED OPTION_REPOSITORY)
    message(ERROR "REPOSITORY argument for declare_option is mandatory")
    message(FATAL_ERROR)
  endif()
  if(NOT DEFINED OPTION_OPTION)
    message(ERROR "OPTION argument for declare_option is mandatory")
    message(FATAL_ERROR)
  endif()
  if(NOT DEFINED OPTION_VALUE)
    message(WARN "Value for ${OPTION_OPTION} assumed to be ${BoldGreen}ON${Default}")
    set(OPTION_VALUE ON)
  endif()

  if(NOT DEFINED ${OPTION_REPOSITORY}_${OPTION_OPTION})

    list(FIND "${OPTION_REPOSITORY}_OPTIONS_LIST" ${OPTION_OPTION} OPTION_FOUND)

    if(${OPTION_FOUND} STREQUAL "-1")

      list(INSERT "${OPTION_REPOSITORY}_OPTIONS_LIST" 0 "${OPTION_OPTION}" "${OPTION_VALUE}")
      list(INSERT "${OPTION_REPOSITORY}_OPTIONS" 0 "${OPTION_OPTION} ${OPTION_VALUE}")

    else()

      math(EXPR OPTION_FOUND_PLUS_ONE "${OPTION_FOUND}+1")
      list(REMOVE_AT "${OPTION_REPOSITORY}_OPTIONS_LIST" ${OPTION_FOUND_PLUS_ONE})
      list(INSERT "${OPTION_REPOSITORY}_OPTIONS_LIST" ${OPTION_FOUND_PLUS_ONE} "${OPTION_VALUE}")
      math(EXPR OPTION_FOUND "${OPTION_FOUND}/2")
      list(REMOVE_AT "${OPTION_REPOSITORY}_OPTIONS" ${OPTION_FOUND})
      list(INSERT "${OPTION_REPOSITORY}_OPTIONS" ${OPTION_FOUND} "${OPTION_OPTION} ${OPTION_VALUE}")

    endif()

  else()

    list(FIND "${OPTION_REPOSITORY}_OPTIONS_LIST" ${OPTION_OPTION} OPTION_FOUND)
    if(${OPTION_FOUND} STREQUAL "-1")
      list(INSERT "${OPTION_REPOSITORY}_OPTIONS_LIST" 0 "${OPTION_OPTION}" "${${OPTION_REPOSITORY}_${OPTION_OPTION}}")
      list(INSERT "${OPTION_REPOSITORY}_OPTIONS" 0 "${OPTION_OPTION} ${${OPTION_REPOSITORY}_${OPTION_OPTION}}")
    else()
      math(EXPR OPTION_FOUND_PLUS_ONE "${OPTION_FOUND}+1")
      list(REMOVE_AT "${OPTION_REPOSITORY}_OPTIONS_LIST" ${OPTION_FOUND_PLUS_ONE})
      list(INSERT "${OPTION_REPOSITORY}_OPTIONS_LIST" ${OPTION_FOUND_PLUS_ONE} "${${OPTION_REPOSITORY}_${OPTION_OPTION}}")
      math(EXPR OPTION_FOUND "${OPTION_FOUND}/2")
      list(REMOVE_AT "${OPTION_REPOSITORY}_OPTIONS" ${OPTION_FOUND})
      list(INSERT "${OPTION_REPOSITORY}_OPTIONS" ${OPTION_FOUND} "${OPTION_OPTION} ${${OPTION_REPOSITORY}_${OPTION_OPTION}}")
    endif()

  endif()
  set(${OPTION_REPOSITORY}_OPTIONS_LIST ${${OPTION_REPOSITORY}_OPTIONS_LIST} CACHE STRING "Options predefined for ${OPTION_REPOSITORY}" FORCE)
  set(${OPTION_REPOSITORY}_OPTIONS ${${OPTION_REPOSITORY}_OPTIONS} CACHE STRING "Options predefined for ${OPTION_REPOSITORY}" FORCE)
endfunction()

function(print_options)
  cmake_parse_arguments(OPTION "" "REPOSITORY" "" ${ARGN})
  if(NOT DEFINED OPTION_REPOSITORY)
    message(ERROR "REPOSITORY argument for declare_option is mandatory")
    message(FATAL_ERROR)
  endif()
  list(LENGTH ${OPTION_REPOSITORY}_OPTIONS_LIST EMPTY)
  if(${EMPTY} STREQUAL 0)
    message(WARN "${OPTION_REPOSITORY} doesn't have options")
    return()
  endif()
  string(APPEND RESULT "Options for ${OPTION_REPOSITORY} :${Reset}\n")
  list(LENGTH ${OPTION_REPOSITORY}_OPTIONS_LIST LENGTH)
  math(EXPR LENGTH "${LENGTH}-1")
  set(ITEM "0")
  foreach(OPTION IN LISTS ${OPTION_REPOSITORY}_OPTIONS_LIST)
    math(EXPR MODULO "${ITEM}%2")
    if(${MODULO} STREQUAL "0")
      string(APPEND RESULT "${BoldMagenta}" "   ${OPTION}" " : ")
    else()
      string(APPEND RESULT "${OPTION}" "${Reset}")
      if(NOT ${ITEM} STREQUAL ${LENGTH})
      string(APPEND RESULT "\n")
      endif()
    endif()
    math(EXPR ITEM "${ITEM}+1")
  endforeach()
  message(INFO "${RESULT}")
endfunction()

function(get_option)
  cmake_parse_arguments(OPTION "" "VARIABLE;OPTION;REPOSITORY" "" ${ARGN})
  list(FIND ${OPTION_REPOSITORY}_OPTIONS_LIST ${OPTION_OPTION} FOUND)
  if(${FOUND} STREQUAL "-1")
    set(VALUE "")
  else()
    math(EXPR FOUND "${FOUND}+1")
    list(GET ${OPTION_REPOSITORY}_OPTIONS_LIST ${FOUND} VALUE)
  endif()
  set(${OPTION_VARIABLE} "${VALUE}" PARENT_SCOPE)
endfunction()

function(undeclare_all_options)
  cmake_parse_arguments(OPTION "" "REPOSITORY" "" ${ARGN})
  if(NOT DEFINED OPTION_REPOSITORY)
    message(ERROR "REPOSITORY argument for declare_option is mandatory")
    message(FATAL_ERROR)
  endif()
  set(${OPTION_REPOSITORY}_OPTIONS_LIST "" CACHE STRING "Options predefined for ${OPTION_REPOSITORY}" FORCE)
  set(${OPTION_REPOSITORY}_OPTIONS "" CACHE STRING "Options predefined for ${OPTION_REPOSITORY}" FORCE)
endfunction()

function(undeclare_option)
  cmake_parse_arguments(OPTION "" "REPOSITORY;OPTION" "" ${ARGN})
  if(NOT DEFINED OPTION_REPOSITORY)
    message(ERROR "REPOSITORY argument for declare_option is mandatory")
    message(FATAL_ERROR)
  endif()
  if(NOT DEFINED OPTION_OPTION)
    message(ERROR "OPTION argument for declare_option is mandatory")
    message(FATAL_ERROR)
  endif()
  list(FIND ${OPTION_REPOSITORY}_OPTIONS_LIST ${OPTION_OPTION} OPTION_FOUND)
  if(NOT ${OPTION_FOUND} STREQUAL "-1")
    math(EXPR OPTION_FOUND_PLUS_ONE "${OPTION_FOUND}+1")
    list(REMOVE_AT ${OPTION_REPOSITORY}_OPTIONS_LIST ${OPTION_FOUND} ${OPTION_FOUND_PLUS_ONE})
    math(EXPR OPTION_FOUND "${OPTION_FOUND}/2")
    list(REMOVE_AT ${OPTION_REPOSITORY}_OPTIONS ${OPTION_FOUND})
  endif()
  set(${OPTION_REPOSITORY}_OPTIONS_LIST "${${OPTION_REPOSITORY}_OPTIONS_LIST}" CACHE STRING "Options predefined for ${OPTION_REPOSITORY}" FORCE)
  set(${OPTION_REPOSITORY}_OPTIONS "${${OPTION_REPOSITORY}_OPTIONS}" CACHE STRING "Options predefined for ${OPTION_REPOSITORY}" FORCE)
endfunction()
