cmake_minimum_required(VERSION 3.10)

project(CLI11Test
        VERSION "1"
        DESCRIPTION "CLI11 Test"
        HOMEPAGE_URL "https://github.com/flagarde/CMakeCM/blob/master/modules/CLI11.cmake"
        LANGUAGES CXX
       )

set(CMAKE_MODULE_PATH "${MODULES_PATH}")

include(Testings)
include(Colors)
include(CLI11)

set(CMAKE_MODULE_PATH "${MODULES_PATH}")

add_executable(TestCLI11 TestCLI11.cpp)
target_link_libraries(TestCLI11 CLI11)
install(TARGETS TestCLI11 RUNTIME DESTINATION bin)
add_test(NAME TestCLI11 COMMAND TestCLI11)
