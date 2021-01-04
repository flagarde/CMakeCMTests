include(Messages)

include(FindPackageHandleStandardArgs)
find_program(SPHINX_APIDOC NAMES sphinx-apidoc PATHS "${PIP_PACKAGES_PATH}/bin" DOC "Path to sphinx-apidoc executable")
find_program(SPHINX_AUTOGEN NAMES sphinx-autogen PATHS "${PIP_PACKAGES_PATH}/bin" DOC "Path to sphinx-autogen executable")
find_program(SPHINX_BUILD NAMES sphinx-build PATHS "${PIP_PACKAGES_PATH}/bin" DOC "Path to sphinx-build executable")
find_program(SPHINX_QUICKSTART NAMES sphinx-quickstart PATHS "${PIP_PACKAGES_PATH}/bin" DOC "Path to sphinx-quickstart executable")
if(NOT SPHINX_APIDOC STREQUAL "SPHINX_APIDOC-NOTFOUND")
  execute_process(COMMAND "${CMAKE_COMMAND}" "-E" "env" "PYTHONPATH=\"${PIP_PACKAGES_PATH}\"" "${CMAKE_COMMAND}" COMMAND "${SPHINX_APIDOC}" "--version" OUTPUT_VARIABLE SPHINX_VERSION_FOUND)
  string(REGEX MATCH "([0-9]+).([0-9]+).([0-9+])" SPHINX_VERSION_FOUND ${SPHINX_VERSION_FOUND})
endif()

find_package_handle_standard_args(Sphinx REQUIRED_VARS SPHINX_APIDOC SPHINX_AUTOGEN SPHINX_BUILD SPHINX_QUICKSTART VERSION_VAR SPHINX_VERSION_FOUND HANDLE_VERSION_RANGE)

