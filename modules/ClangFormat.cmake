include_guard(GLOBAL)

include(Messages)

find_program(CLANG_FORMAT_PROGRAM clang-format)

option(FORMAT_CHECK_CODE "Enable code formatting." TRUE)

if(NOT FORMAT_CHECK_CODE AND CLANG_FORMAT_PROGRAM)
  message(WARN "clang-format desactivated but you have the program !")
  message(WARN "Use FORMAT_CHECK_CODE to activate it !")
  return()
elseif(NOT FORMAT_CHECK_CODE AND NOT CLANG_FORMAT_PROGRAM)
  message(WARN "clang-format desactivated !")
  message(WARN "Install clang-format and used FORMAT_CHECK_CODE to activate it !")
  return()
endif()

if(CLANG_FORMAT_PROGRAM)
  message(STATUS "${BoldMagenta}[CMakeCM] Downloading git-clang-format.py${Reset}")
  set(DOWNLOAD_GIT_CLANG_FORMAT_URL "https://raw.githubusercontent.com/flagarde/CMakeCM/master/tools/git-clang-format.py" CACHE STRING "URL of git-clang-format.py")
  set(DOWNLOAD_GIT_CLANG_FORMAT_SHA256 "2c2340c00fa632ed1531c027e1683266509dbf27bd276f8dcd1c5644bebad0a4" CACHE STRING "SHA256 of git-clang-format.py")
  file(
    DOWNLOAD "${DOWNLOAD_GIT_CLANG_FORMAT_URL}" "${CMAKE_BINARY_DIR}/cmake/CMakeCM/git-clang-format.py"
    INACTIVITY_TIMEOUT 5
    TIMEOUT 5
    EXPECTED_HASH SHA256=${DOWNLOAD_GIT_CLANG_FORMAT_SHA256}
    )

  set(CLANG_FORMAT_COMMAND python "${CMAKE_BINARY_DIR}/cmake/CMakeCM/git-clang-format.py" --binary=${CLANG_FORMAT_PROGRAM})
  set(GIT_EMPTY_TREE_HASH 4b825dc642cb6eb9a060e54bf8d69288fbee4904)

  add_custom_target(clang-format COMMAND ${CLANG_FORMAT_COMMAND} --diff ${GIT_EMPTY_TREE_HASH} WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})

  add_custom_target(check-clang-format COMMAND ${CLANG_FORMAT_COMMAND} --ci ${GIT_EMPTY_TREE_HASH} WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})

  add_custom_target(fix-clang-format COMMAND ${CLANG_FORMAT_COMMAND} ${GIT_EMPTY_TREE_HASH} -f WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
else()
  message(STATUS "clang-format not found: adding dummy Format.cmake targets")

  set(CLANG_FORMAT_NOT_FOUND_COMMAND_ARGS COMMAND ${CMAKE_COMMAND} -E echo "cannot run Format.cmake: clang-format not found" COMMAND ${CMAKE_COMMAND} -E false)

  add_custom_target(clang-format ${CLANG_FORMAT_NOT_FOUND_COMMAND_ARGS})
  add_custom_target(check-clang-format ${CLANG_FORMAT_NOT_FOUND_COMMAND_ARGS})
  add_custom_target(fix-clang-format ${CLANG_FORMAT_NOT_FOUND_COMMAND_ARGS})

  list(APPEND FORMAT_TARGETS clang-format)
  list(APPEND CHECK_FORMAT_TARGETS check-clang-format)
  list(APPEND FIX_FORMAT_TARGETS fix-clang-format)

  if(NOT TARGET format)
    add_custom_target(format)
  endif()
  if(NOT TARGET check-format)
    add_custom_target(check-format)
  endif()
  if(NOT TARGET fix-format)
    add_custom_target(fix-format)
  endif()

  add_dependencies(format ${FORMAT_TARGETS})
  add_dependencies(check-format ${CHECK_FORMAT_TARGETS})
  add_dependencies(fix-format ${FIX_FORMAT_TARGETS})

endif()
