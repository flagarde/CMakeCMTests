include(Messages)

include(FindPackageHandleStandardArgs)
find_program(BREATHE_EXECUTABLE NAMES breathe-apidoc PATHS "${PIP_PACKAGES_PATH}/bin" DOC "Path to breathe-apidoc executable")
if(NOT BREATHE_EXECUTABLE STREQUAL "BREATHE_EXECUTABLE-NOTFOUND")
  execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "env" "PYTHONPATH=\"${PIP_PACKAGES_PATH}\"" "${CMAKE_COMMAND}" COMMAND "${BREATHE_EXECUTABLE}" "--version" OUTPUT_VARIABLE BREATHE_VERSION_FOUND)
  string(REGEX MATCH "([0-9]+).([0-9]+).([0-9+])" BREATHE_VERSION_FOUND ${BREATHE_VERSION_FOUND})
endif()

find_package_handle_standard_args(Breathe REQUIRED_VARS BREATHE_EXECUTABLE VERSION_VAR BREATHE_VERSION_FOUND HANDLE_VERSION_RANGE)
