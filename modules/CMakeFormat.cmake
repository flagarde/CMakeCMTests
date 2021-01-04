include_guard(GLOBAL)

get_property(IS_CMAKE_ROLE GLOBAL PROPERTY CMAKE_ROLE)

if(${IS_CMAKE_ROLE} STREQUAL "SCRIPT")

  # Regex-filter a git repository's files.
  function(get_cmake_files)
    cmake_parse_arguments("" "" "GIT_REPOSITORY_DIR;OUTPUT_LIST;REGEX" "" ${ARGN})
    execute_process(COMMAND ${GIT_PROGRAM} ls-files --cached --exclude-standard ${_GIT_REPOSITORY_DIR} WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} OUTPUT_VARIABLE all_files)
    cmake_policy(SET CMP0007 NEW)
    string(REPLACE "\n" ";" filtered_files "${all_files}")
    list(FILTER filtered_files INCLUDE REGEX ${_REGEX})
    set(${_OUTPUT_LIST} ${filtered_files} PARENT_SCOPE)
  endfunction()

  execute_process(COMMAND git rev-parse --show-toplevel OUTPUT_VARIABLE GIT_TOPLEVEL WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})

  # remove trailing whitespace from output
  string(STRIP ${GIT_TOPLEVEL} GIT_TOPLEVEL)

  get_cmake_files(GIT_REPOSITORY_DIR ${GIT_TOPLEVEL} OUTPUT_LIST CMAKE_FILES REGEX "\\.cmake$|(^|/)CMakeLists\\.txt$")

  if(CMAKE_FORMAT_TARGET STREQUAL fix-cmake-format)
    execute_process(COMMAND ${CMAKE_FORMAT_PROGRAM} -i ${CMAKE_FILES})
    return()
  endif()

  if(CMAKE_FORMAT_TARGET STREQUAL check-cmake-format)
    set(OUTPUT_QUIET_OPTION OUTPUT_QUIET)
  endif()

  set(formatted_cmake_file ${BINARY_DIR}/formatted.cmake)
  foreach(cmake_file IN LISTS CMAKE_FILES)
    if(NOT EXISTS ${cmake_file})
      message(STATUS "File ${cmake_file} suppressed")
    else()
      set(source_cmake_file ${CMAKE_SOURCE_DIR}/${cmake_file})
      execute_process(COMMAND ${CMAKE_FORMAT_PROGRAM} -o ${formatted_cmake_file} ${source_cmake_file})
      execute_process(COMMAND ${GIT_PROGRAM} diff --color --no-index -- ${source_cmake_file} ${formatted_cmake_file} RESULT_VARIABLE result ${OUTPUT_QUIET_OPTION})
      if(OUTPUT_QUIET_OPTION AND result)
        message(FATAL_ERROR "${cmake_file} needs to be reformatted")
      endif()
    endif()
  endforeach()

elseif(${IS_CMAKE_ROLE} STREQUAL "PROJECT")

  include(Messages)

  option(FORMAT_CHECK_CMAKE "Enable CMake formatting." TRUE)

  find_package(Git)
  find_program(CMAKE_FORMAT_PROGRAM cmake-format)

  if(GIT_FOUND AND CMAKE_FORMAT_PROGRAM AND NOT FORMAT_CHECK_CMAKE)
    message(WARN "cmake-format desactivated but you have the program !")
    message(WARN "Use FORMAT_CHECK_CMAKE to activate it !")
    return()
  elseif(GIT_FOUND AND NOT CMAKE_FORMAT_PROGRAM AND NOT FORMAT_CHECK_CMAKE)
    message(WARN "clang-format desactivated !")
    message(WARN "Install cmake-format and used FORMAT_CHECK_CMAKE to activate it !")
    return()
  elseif(NOT GIT_FOUND AND CMAKE_FORMAT_PROGRAM AND NOT FORMAT_CHECK_CMAKE)
    message(WARN "clang-format desactivated !")
    message(WARN "You have cmake-format but you need to install Git, then use FORMAT_CHECK_CMAKE to activate it !")
    return()
  endif()

  if(GIT_FOUND AND CMAKE_FORMAT_PROGRAM)
    function(add_cmake_format_target name)
      add_custom_target(
        ${name} COMMAND ${CMAKE_COMMAND} -DGIT_PROGRAM=${GIT_EXECUTABLE} -DCMAKE_FORMAT_PROGRAM=${CMAKE_FORMAT_PROGRAM} -DCMAKE_FORMAT_TARGET=${name} -DBINARY_DIR="${CMAKE_CURRENT_BINARY_DIR}" -P
                        ${CMAKE_CURRENT_LIST_DIR}/CMakeFormat.cmake WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        )
    endfunction()

    add_cmake_format_target(cmake-format)
    add_cmake_format_target(check-cmake-format)
    add_cmake_format_target(fix-cmake-format)

  elseif(NOT GIT_FOUND OR NOT CMAKE_FORMAT_PROGRAM)
    if(NOT GIT_FOUND AND NOT CMAKE_FORMAT_PROGRAM)
      message(WARN "Git and cmake-format are not found ! Can't format cmake files")
      return()
    elseif(NOT GIT_FOUND)
      message(WARN "Git not found ! Can't format cmake files")
      return()
    else()
      message(WARN "cmake-format not found ! Can't format cmake files")
      return()
    endif()

    set(CMAKE_FORMAT_NOT_FOUND_COMMAND_ARGS COMMAND ${CMAKE_COMMAND} -E echo "cannot run Format.cmake: cmake-format or git not found" COMMAND ${CMAKE_COMMAND} -E false)

    add_custom_target(cmake-format ${CMAKE_FORMAT_NOT_FOUND_COMMAND_ARGS})
    add_custom_target(check-cmake-format ${CMAKE_FORMAT_NOT_FOUND_COMMAND_ARGS})
    add_custom_target(fix-cmake-format ${CMAKE_FORMAT_NOT_FOUND_COMMAND_ARGS})
  endif()

  if(NOT TARGET format)
    add_custom_target(format)
  endif()
  if(NOT TARGET check-format)
    add_custom_target(check-format)
  endif()
  if(NOT TARGET fix-format)
    add_custom_target(fix-format)
  endif()

  if(FORMAT_CHECK_CMAKE)
    list(APPEND FORMAT_TARGETS cmake-format)
    list(APPEND CHECK_FORMAT_TARGETS check-cmake-format)
    list(APPEND FIX_FORMAT_TARGETS fix-cmake-format)
    add_dependencies(format ${FORMAT_TARGETS})
    add_dependencies(check-format ${CHECK_FORMAT_TARGETS})
    add_dependencies(fix-format ${FIX_FORMAT_TARGETS})
  endif()
endif()
