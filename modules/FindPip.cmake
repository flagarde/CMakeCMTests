include_guard(GLOBAL)

if(Python3_FOUND)
  include(Python)
endif()

include(FindPackageHandleStandardArgs)
if(NOT "$ENV{VIRTUAL_ENV}" STREQUAL "")
  find_program(pip_EXECUTABLE NAMES pip pip3 PATHS "$ENV{VIRTUAL_ENV}/bin" "$ENV{VIRTUAL_ENV}/Scripts" DOC "Path to pip executable." NO_DEFAULT_PATH)
else()
  find_program(pip_EXECUTABLE NAMES pip pip3 DOC "Path to pip executable.")
endif()
if(NOT pip_EXECUTABLE STREQUAL "pip-NOTFOUND")
  execute_process(COMMAND "${pip_EXECUTABLE}" -V OUTPUT_VARIABLE pip_VERSION)
  string(REGEX MATCH "([0-9]+).([0-9]+).([0-9+])" pip_VERSION "${pip_VERSION}")
  get_property(_findpip_role GLOBAL PROPERTY CMAKE_ROLE)
  if(_findpip_role STREQUAL "PROJECT" AND NOT TARGET Pip::Pip)
    add_executable(Pip::Pip IMPORTED)
    set_property(TARGET Pip::Pip PROPERTY IMPORTED_LOCATION "${pip_EXECUTABLE}")
  endif()
endif()

if(CMAKE_VERSION VERSION_LESS "3.19")
  find_package_handle_standard_args(Pip REQUIRED_VARS pip_EXECUTABLE VERSION_VAR pip_VERSION)
else()
  find_package_handle_standard_args(Pip REQUIRED_VARS pip_EXECUTABLE VERSION_VAR pip_VERSION HANDLE_VERSION_RANGE)
endif()

function(install_with_pip)
  cmake_parse_arguments(PIP "" "NAME" "OPTIONS" ${ARGN})
  #workaround problem with windows pip
  if(Python3_DOWNLOADED AND WIN32)
    set(PIP_COMMAND "${Python3_EXECUTABLE} -m pip")
  else()
    set(PIP_COMMAND "${pip_EXECUTABLE}")
  endif()
  if(NOT DEFINED PIP_NAME)
    message(FATAL_ERROR "Option NAME is required !")
  endif()
  if(NOT DEFINED PIP_OPTIONS)
    execute_process(COMMAND "${PIP_COMMAND}" "install" "${PIP_NAME}" COMMAND_ECHO STDOUT)
  else()
    string(REPLACE ";" " " PIP_OPTIONS "${PIP_OPTIONS}")
    execute_process(COMMAND "${PIP_COMMAND}" "install" "${PIP_NAME}" "${PIP_OPTIONS}"  COMMAND_ECHO STDOUT)
  endif()
endfunction()