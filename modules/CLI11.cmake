include_guard(GLOBAL)

include(CPM)
cpm()

if(NOT DEFINED CLI11_REPOSITORY)
  set(CLI11_REPOSITORY "CLIUtils/CLI11")
endif()

if(NOT DEFINED CLI11_VERSION)
  set(CLI11_VERSION "v1.9.1")
endif()

declare_option(REPOSITORY CLI11 OPTION CMAKE_CXX_STANDARD VALUE "11")
declare_option(REPOSITORY CLI11 OPTION CMAKE_CXX_STANDARD_REQUIRED VALUE TRUE)
declare_option(REPOSITORY CLI11 OPTION CMAKE_CXX_EXTENSIONS VALUE FALSE)
declare_option(REPOSITORY CLI11 OPTION CMAKE_INSTALL_PREFIX VALUE "${CMAKE_INSTALL_PREFIX}")
declare_option(REPOSITORY CLI11 OPTION CLI11_BUILD_DOCS VALUE OFF)
declare_option(REPOSITORY CLI11 OPTION CLI11_BUILD_TESTS VALUE OFF)
declare_option(REPOSITORY CLI11 OPTION CLI11_BUILD_EXAMPLES VALUE OFF)
declare_option(REPOSITORY CLI11 OPTION CLI11_BUILD_EXAMPLES_JSON VALUE OFF)
declare_option(REPOSITORY CLI11 OPTION CLI11_SINGLE_FILE_TESTS VALUE OFF)
declare_option(REPOSITORY CLI11 OPTION CLI11_INSTALL VALUE ON)
declare_option(REPOSITORY CLI11 OPTION CLI11_FORCE_LIBCXX VALUE OFF)
declare_option(REPOSITORY CLI11 OPTION CLI11_CUDA_TESTS VALUE OFF)
declare_option(REPOSITORY CLI11 OPTION CLI11_CLANG_TIDY VALUE OFF)
print_options(REPOSITORY  CLI11)

CPMFindPackage(NAME CLI11
               GITHUB_REPOSITORY ${CLI11_REPOSITORY}
               GIT_TAG ${CLI11_VERSION}
               FETCHCONTENT_UPDATES_DISCONNECTED ${IS_OFFLINE}
               OPTIONS "${CLI11_OPTIONS}"
              )
