include_guard(GLOBAL)

include(Messages)
include(CreateConfigurationTypes)

# C Compiler
if(DEFINED CMAKE_C_COMPILER_ID)
  if(${CMAKE_C_COMPILER_ID} STREQUAL "GNU")
    add_configuration(CONFIG Coverage C_FLAGS "-g0" "--coverage")
  elseif(${CMAKE_C_COMPILER_ID} MATCHES "(Apple)?[Cc]lang")
    add_configuration(CONFIG Coverage C_FLAGS "-g0" "-fprofile-instr-generate" "-fcoverage-mapping")
  else()
    message(WARN "Coverage is not supported by your C compiler \"${CMAKE_C_COMPILER_ID}\" !")
    message(WARN "Coverage is equivalent to Debug !")
    add_configuration(CONFIG Coverage BASE_CONFIG Debug)
  endif()
endif()
# CXX Compiler
if(DEFINED CMAKE_CXX_COMPILER_ID)
  if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    add_configuration(CONFIG Coverage CXX_FLAGS "-g0" "--coverage")
  elseif(${CMAKE_CXX_COMPILER_ID} MATCHES "(Apple)?[Cc]lang")
    add_configuration(CONFIG Coverage CXX_FLAGS "-g0" "-fprofile-instr-generate" "-fcoverage-mapping")
  else()
    message(WARN "Coverage is not supported by your CXX compiler $\"${CMAKE_CXX_COMPILER_ID}\" !")
    message(WARN "Coverage is equivalent to Debug !")
    add_configuration(CONFIG Coverage BASE_CONFIG Debug)
  endif()
endif()

# AllWarnings
if(DEFINED CMAKE_C_COMPILER_ID)
  if(${CMAKE_C_COMPILER_ID} STREQUAL "GNU")
    add_configuration(CONFIG AllWarnings C_FLAGS "-Wall" "-pedantic" "-Wextra")
  elseif(${CMAKE_C_COMPILER_ID} MATCHES "(Apple)?[Cc]lang")
    add_configuration(CONFIG AllWarnings C_FLAGS "-Wall" "-pedantic" "-Wextra")
  elseif(${CMAKE_C_COMPILER_ID} STREQUAL "MSVC")
    add_configuration(CONFIG AllWarnings CXX_FLAGS "/W4")
  endif()
endif()
# CXX Compiler
if(DEFINED CMAKE_CXX_COMPILER_ID)
  if(${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU")
    add_configuration(CONFIG AllWarnings CXX_FLAGS "-Wall" "-pedantic" "-Wextra")
  elseif(${CMAKE_CXX_COMPILER_ID} MATCHES "(Apple)?[Cc]lang")
    add_configuration(CONFIG AllWarnings CXX_FLAGS "-Wall" "-pedantic" "-Wextra")
  elseif(${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
    add_configuration(CONFIG AllWarnings CXX_FLAGS "/W4")
  endif()
endif()
