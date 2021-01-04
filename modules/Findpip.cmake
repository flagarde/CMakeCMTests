include_guard(GLOBAL)

include(Messages)

include(FindPackageHandleStandardArgs)
find_program(PIP_EXECUTABLE NAMES pip PATHS "${CMAKE_BINARY_DIR}/python/bin" DOC "Path to pip executable.")
if(NOT PIP_EXECUTABLE STREQUAL "PIP_EXECUTABLE-NOTFOUND")
  execute_process(COMMAND ${PIP_EXECUTABLE} -V OUTPUT_VARIABLE PIP_VERSION_FOUND)
  string(REGEX MATCH "([0-9]+).([0-9]+).([0-9+])" PIP_VERSION_FOUND ${PIP_VERSION_FOUND})
endif()

find_package_handle_standard_args(pip REQUIRED_VARS PIP_EXECUTABLE VERSION_VAR PIP_VERSION_FOUND)
