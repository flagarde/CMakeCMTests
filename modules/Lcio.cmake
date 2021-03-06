#include_guard(GLOBAL)

include(CPM)
cpm()

if(DEFINED ENV{LCIO})
  set(CMAKE_PREFIX_PATH "$ENV{LCIO};${CMAKE_PREFIX_PATH}" CACHE PATH "CMAKE_PREFIX_PATH" FORCE)
  message(INFO "LCIO environment found $ENV{LCIO}")
endif()

if(NOT DEFINED LCIO_REPOSITORY)
  set(LCIO_REPOSITORY "iLCSoft/LCIO")
endif()

if(NOT DEFINED LCIO_VERSION)
  set(LCIO_VERSION "v02-16")
endif()

declare_option(REPOSITORY lcio OPTION CMAKE_CXX_STANDARD VALUE 14)
declare_option(REPOSITORY lcio OPTION CMAKE_CXX_STANDARD_REQUIRED VALUE TRUE)
declare_option(REPOSITORY lcio OPTION CMAKE_CXX_EXTENSIONS VALUE FALSE)
declare_option(REPOSITORY lcio OPTION CMAKE_INSTALL_PREFIX VALUE ${CMAKE_INSTALL_PREFIX})
declare_option(REPOSITORY lcio OPTION LCIO_SET_RPATH VALUE ON)
declare_option(REPOSITORY lcio OPTION INSTALL_JAR VALUE OFF)
declare_option(REPOSITORY lcio OPTION LCIO_GENERATE_HEADERS VALUE OFF)
declare_option(REPOSITORY lcio OPTION BUILD_ROOTDICT VALUE OFF)
declare_option(REPOSITORY lcio OPTION BUILD_LCIO_EXAMPLES VALUE OFF)
declare_option(REPOSITORY lcio OPTION BUILD_F77_TESTJOBS VALUE OFF)
declare_option(REPOSITORY lcio OPTION INSTALL_DOC VALUE OFF)
print_options(REPOSITORY  lcio)

CPMFindPackage(NAME lcio
               GITHUB_REPOSITORY ${LCIO_REPOSITORY}
               GIT_TAG ${LCIO_VERSION}
               FETCHCONTENT_UPDATES_DISCONNECTED ${IS_OFFLINE}
               OPTIONS ${LCIO_OPTIONS}
              )

if (lcio_ADDED)
  # compile with C++17
  target_include_directories(lcio INTERFACE "${lcio_SOURCE_DIR}/src/cpp/include/")
  message(STATUS "************** ${lcio_SOURCE_DIR}/src/cpp/include/")
  target_include_directories(lcio INTERFACE "${lcio_SOURCE_DIR}/src/cpp/include/pre-generated")
  #set_target_properties(benchmark PROPERTIES CXX_STANDARD 17)
endif()
