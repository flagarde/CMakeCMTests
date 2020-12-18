include_guard(GLOBAL)

include(CPM)
cpm()

if(NOT DEFINED DOCTEST_REPOSITORY)
  set(DOCTEST_REPOSITORY "onqtam/doctest")
endif()

if(NOT DEFINED DOCTEST_VERSION)
  set(DOCTEST_VERSION "2.4.3")
endif()

declare_option(REPOSITORY doctest OPTION CMAKE_CXX_STANDARD VALUE 11)
declare_option(REPOSITORY doctest OPTION CMAKE_CXX_STANDARD_REQUIRED VALUE TRUE)
declare_option(REPOSITORY doctest OPTION CMAKE_CXX_EXTENSIONS VALUE FALSE)
declare_option(REPOSITORY doctest OPTION CMAKE_INSTALL_PREFIX VALUE ${CMAKE_INSTALL_PREFIX})
declare_option(REPOSITORY doctest OPTION DOCTEST_WITH_TESTS VALUE OFF)
declare_option(REPOSITORY doctest OPTION DOCTEST_WITH_MAIN_IN_STATIC_LIB VALUE ON)
declare_option(REPOSITORY doctest OPTION DOCTEST_NO_INSTALL VALUE OFF)
declare_option(REPOSITORY doctest OPTION DOCTEST_USE_STD_HEADERS VALUE ON)
print_options(REPOSITORY  doctest)

CPMFindPackage(NAME doctest
               GITHUB_REPOSITORY ${DOCTEST_REPOSITORY}
               GIT_TAG ${DOCTEST_VERSION}
               FETCHCONTENT_UPDATES_DISCONNECTED ${IS_OFFLINE}
               OPTIONS ${DOCTEST_OPTIONS}
              )

if(doctest_ADDED)
  include("${doctest_SOURCE_DIR}/scripts/cmake/doctest.cmake")
else()
  include("${CMAKE_INSTALL_PREFIX}/lib/cmake/doctest/doctest.cmake")
  if(EXISTS "${doctest_BINARY_DIR}/libdoctest_with_main.a")
    configure_file("${doctest_BINARY_DIR}/libdoctest_with_main.a" "${CMAKE_INSTALL_PREFIX}/lib/libdoctest_with_main.a" COPYONLY)
    add_library(doctest_with_main INTERFACE IMPORTED)
    target_link_libraries(doctest_with_main INTERFACE "${CMAKE_INSTALL_PREFIX}/lib/libdoctest_with_main.a")
  endif()
endif()
