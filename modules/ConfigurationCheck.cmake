include_guard(GLOBAL)

include(Messages)

set(ALLOWABLE_BUILD_TYPES "Debug" "MinSizeRel" "RelWithDebInfo" "Release" "None")
set(LANGUAGES
    "C"
    "CXX"
    "CUDA"
    "OBJC"
    "OBJCXX"
    "Fortran"
    "ASM"
  )

function(print_configuration config)
  string(TOUPPER ${config} CONFIG)
  message(INFO "CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG} : ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG}}")
  message(INFO "CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY_${CONFIG} : ${CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY_${CONFIG}}")
  message(INFO "CMAKE_${CONFIG}_POSTFIX : ${CMAKE_${CONFIG}_POSTFIX}")
  message(INFO "CMAKE_EXE_LINKER_FLAGS_${CONFIG} : ${CMAKE_EXE_LINKER_FLAGS_${CONFIG}}")
  message(INFO "CMAKE_FRAMEWORK_MULTI_CONFIG_POSTFIX_${CONFIG} : ${CMAKE_FRAMEWORK_MULTI_CONFIG_POSTFIX_${CONFIG}}")
  message(INFO "CMAKE_INTERPROCEDURAL_OPTIMIZATION_${CONFIG} : ${CMAKE_INTERPROCEDURAL_OPTIMIZATION_${CONFIG}}")
  message(INFO "CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG} : ${CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG}}")
  message(INFO "CMAKE_MAP_IMPORTED_CONFIG_${CONFIG} : ${CMAKE_MAP_IMPORTED_CONFIG_${CONFIG}}")
  message(INFO "CMAKE_MODULE_LINKER_FLAGS_${CONFIG} : ${CMAKE_MODULE_LINKER_FLAGS_${CONFIG}}")
  message(INFO "CMAKE_PDB_OUTPUT_DIRECTORY_${CONFIG} : ${CMAKE_PDB_OUTPUT_DIRECTORY_${CONFIG}}")
  message(INFO "CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG} : ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG}}")
  message(INFO "CMAKE_SHARED_LINKER_FLAGS_${CONFIG} : ${CMAKE_SHARED_LINKER_FLAGS_${CONFIG}}")
  message(INFO "CMAKE_STATIC_LINKER_FLAGS_${CONFIG} : ${CMAKE_STATIC_LINKER_FLAGS_${CONFIG}}")
  foreach(LANGUAGE IN LISTS IN LANGUAGES)
    message(INFO "CMAKE_${LANGUAGE}_FLAGS_${CONFIG} : ${CMAKE_${LANGUAGE}_FLAGS_${CONFIG}}")
  endforeach()
endfunction()

function(configuration_exists)
  cmake_parse_arguments(ARG "VERBOSE" "NAME;RESULT" "" ${ARGN})
  if(NOT DEFINED ARG_NAME)
    message(FATAL_ERROR "NAME is mandatory")
  endif()
  if(${ARG_NAME} IN_LIST ALLOWABLE_BUILD_TYPES)
    if(NOT DEFINED ARG_RESULT)
      message(INFO "${ARG_NAME} configuration exists")
    else()
      if(ARG_VERBOSE)
        message(INFO "${ARG_NAME} configuration exists")
      endif()
      set(${ARG_RESULT} TRUE PARENT_SCOPE)
    endif()
  else()
    if(NOT DEFINED ARG_RESULT)
      message(INFO "${ARG_NAME} configuration does not exists")
    else()
      if(ARG_VERBOSE)
        message(INFO "${ARG_NAME} configuration does not exists")
      endif()
      set(${ARG_RESULT} FALSE PARENT_SCOPE)
    endif()
  endif()
endfunction()

function(set_default_configuration type)
  cmake_parse_arguments(ARG "VERBOSE" "" "" ${ARGN})
  if(NOT CMAKE_CONFIGURATION_TYPES)
    list(SORT ALLOWABLE_BUILD_TYPES COMPARE STRING)
    list(REMOVE_DUPLICATES ALLOWABLE_BUILD_TYPES)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "${ALLOWABLE_BUILD_TYPES}")
    list(JOIN ALLOWABLE_BUILD_TYPES ", " STRING_ALLOWABLE_BUILD_TYPES)
    configuration_exists(NAME ${type} RESULT CONFIG_EXISTS)
    if(CONFIG_EXISTS)
      if(NOT ${CMAKE_BUILD_TYPE} STREQUAL "" AND NOT ${CMAKE_BUILD_TYPE} STREQUAL ${type})
        configuration_exists(NAME ${CMAKE_BUILD_TYPE} RESULT USER_CONFIG_EXISTS)
        if(USER_CONFIG_EXISTS)
          message(NOTE "Default configuration type set to ${type} but the user required ${CMAKE_BUILD_TYPE}")
        else()
          message(WARN "Default configuration type set to ${type} but the user required ${CMAKE_BUILD_TYPE}, this configuration does not exists")
          message(WARN "Please choose a configuration in this list : ${STRING_ALLOWABLE_BUILD_TYPES}")
          message(WARN "Falling back to default configuration ${type}")
          set(CMAKE_BUILD_TYPE ${type} CACHE STRING "Default configuration type" FORCE)
        endif()
      else()
        set(CMAKE_BUILD_TYPE ${type} CACHE STRING "Default configuration type" FORCE)
        message(NOTE "Default configuration type set to ${CMAKE_BUILD_TYPE}")
      endif()
    else()
      message(FATAL_ERROR "Invalid build type : ${type}\nCMAKE_BUILD_TYPE should be on the list : ${STRING_ALLOWABLE_BUILD_TYPES}")
    endif()
    if(ARG_VERBOSE)
      print_configuration(${CMAKE_BUILD_TYPE})
      message(NOTE "----------------")
    endif()
  endif()
endfunction()
