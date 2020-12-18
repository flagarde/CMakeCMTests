include(Colors)

include_guard(GLOBAL)

# CMake default message groups
list(
  APPEND
  DEFAULT_MESSAGE_MODES
  "FATAL_ERROR"
  "SEND_ERROR"
  "WARNING"
  "AUTHOR_WARNING"
  "DEPRECATION"
  "NOTICE"
  "STATUS"
  "VERBOSE"
  "DEBUG"
  "TRACE"
  "CHECK_START"
  "CHECK_FAIL"
  "CHECK_PASS"
  )

list(APPEND MESSAGE_MODES ${DEFAULT_MESSAGE_MODES})

macro(add_message_mode)
  set(oneValueArgs NAME CMAKE_MODE STYLE APPEND_BEGIN APPEND_END APPEND_STYLE)
  cmake_parse_arguments(ARG "" "${oneValueArgs}" "" ${ARGN})
  string(TOUPPER ${ARG_NAME} UPPER_ARG_NAME)
  if(NOT ${ARG_NAME} STREQUAL ${UPPER_ARG_NAME})
    message(FATAL_ERROR "NAME is not an upper case word !")
  endif()
  if(NOT "${ARG_NAME}" STREQUAL "")
    list(APPEND MESSAGE_MODES "${MESSAGE_MODES}" "${UPPER_ARG_NAME}")
    list(REMOVE_DUPLICATES MESSAGE_MODES)
  endif()
  if(NOT DEFINED ARG_CMAKE_MODE)
    list(FIND DEFAULT_MESSAGE_MODES ${ARG_NAME} MODE_FOUND)
    if(${MODE_FOUND} STREQUAL "-1")
      set(${ARG_NAME}_CMAKE_MODE "")
    else()
      # CMake Type case
      set(${ARG_NAME}_CMAKE_MODE ${ARG_NAME})
    endif()
  else()
    list(FIND DEFAULT_MESSAGE_MODES ${ARG_CMAKE_MODE} MODE_FOUND)
    if(${MODE_FOUND} STREQUAL "-1")
      list(JOIN DEFAULT_MESSAGE_MODES ", " STRING_DEFAULT_MESSAGE_MODES)
      message(FATAL_ERROR "CMAKE_MODE must be in this list : ${STRING_DEFAULT_MESSAGE_MODES}")
    else()
      set(${ARG_NAME}_CMAKE_MODE ${ARG_CMAKE_MODE})
    endif()
  endif()
  if(NOT ${ARG_STYLE} STREQUAL "")
    set(${ARG_NAME}_STYLE ${ARG_STYLE})
  else()
    set(${ARG_NAME}_STYLE Reset)
  endif()
  if(NOT ${ARG_APPEND_BEGIN} STREQUAL "")
    set(${ARG_NAME}_APPEND_BEGIN "${ARG_APPEND_BEGIN} ")
  endif()
  if(NOT ${ARG_APPEND_END} STREQUAL "")
    set(${ARG_NAME}_APPEND_END " ${ARG_APPEND_END}")
  endif()
  set(${ARG_NAME}_APPEND_STYLE ${ARG_APPEND_STYLE})
endmacro()

# CMake default message types
add_message_mode(NAME FATAL_ERROR STYLE BoldRed)
add_message_mode(NAME SEND_ERROR STYLE BoldRed)
add_message_mode(NAME WARNING STYLE BoldYellow)
add_message_mode(NAME AUTHOR_WARNING STYLE BoldYellow)
add_message_mode(NAME DEPRECATION STYLE Yellow)
add_message_mode(NAME NOTICE)
add_message_mode(NAME STATUS)
add_message_mode(NAME VEBOSE)
add_message_mode(NAME DEBUG)
add_message_mode(NAME TRACE)
# CMake default check types
add_message_mode(NAME CHECK_START)
add_message_mode(NAME CHECK_FAIL)
add_message_mode(NAME CHECK_PASS)
# CMakeCM default message types
add_message_mode(
  NAME
  NOTE
  STYLE
  BoldMagenta
  APPEND_BEGIN
  "--"
  APPEND_END
  "--"
  APPEND_STYLE
  BoldMagenta
  )
add_message_mode(
  NAME
  INFO
  STYLE
  BoldGreen
  APPEND_BEGIN
  "**"
  APPEND_END
  "**"
  APPEND_STYLE
  BoldGreen
  )
add_message_mode(
  NAME
  WARN
  STYLE
  BoldYellow
  APPEND_BEGIN
  "##"
  APPEND_END
  "##"
  APPEND_STYLE
  BoldYellow
  )
add_message_mode(
  NAME
  ERROR
  STYLE
  BoldRed
  APPEND_BEGIN
  "!!"
  APPEND_END
  "!!"
  APPEND_STYLE
  BoldRed
  )

set(Default "\${Default}")

function(message)
  if(${ARGC} STREQUAL "1")
    string(REPLACE "\${Default}" "${Reset}" ARGV ${ARGV})
    _message("${ARGV}")
    return()
  endif()

  list(GET ARGV 0 MESSAGE_MODE)
  list(FIND MESSAGE_MODES ${MESSAGE_MODE} MESSAGE_MODE_FOUND)
  if(NOT ${MESSAGE_MODE_FOUND} STREQUAL "-1")
    list(REMOVE_AT ARGV 0)
    list(JOIN ARGV ";" STRING_ARGV)
    if(NOT STRING_ARGV STREQUAL "")
      string(REPLACE "\${Default}" "${${${MESSAGE_MODE}_STYLE}}" STRING_ARGV ${STRING_ARGV})
    endif()
    _message(
      ${${MESSAGE_MODE}_CMAKE_MODE}
      ${Reset}${${${MESSAGE_MODE}_APPEND_STYLE}}${${MESSAGE_MODE}_APPEND_BEGIN}${Reset}${${${MESSAGE_MODE}_STYLE}}${STRING_ARGV}${Reset}${${${MESSAGE_MODE}_APPEND_STYLE}}${${MESSAGE_MODE}_APPEND_END}${Reset}
      )
  else()
    _message(${ARGV})
  endif()
endfunction()
