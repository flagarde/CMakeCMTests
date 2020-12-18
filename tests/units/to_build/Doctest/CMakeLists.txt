cmake_minimum_required(VERSION 3.10...3.19)
project(DoctestTest
        VERSION "1"
        DESCRIPTION "Doctest Test"
        HOMEPAGE_URL "https://github.com/flagarde/CMakeCM/blob/master/modules/Doctest.cmake"
        LANGUAGES CXX
       )

enable_testing()


set(CMAKE_MODULE_PATH "${MODULES_PATH}")

include(Doctest)

add_executable(TestDoctest Factorial.cpp)
target_link_libraries(TestDoctest doctest)
install(TARGETS TestDoctest RUNTIME DESTINATION bin)
doctest_discover_tests(TestDoctest)
