cmake_minimum_required(VERSION 3.12)
project(Test  LANGUAGES CXX)

set(CMAKE_CXX_STANDARD "11")

set(ENABLE_COVERAGE ON CACHE BOOL "")
include(../../CMakeCM.cmake)

file(DOWNLOAD https://cdn.statically.io/gh/catchorg/Catch2/v2.11.0/single_include/catch2/catch.hpp ${CMAKE_BINARY_DIR}/catch.hpp)

include(codecov)

add_executable(dummy-user test.cpp)
target_include_directories(dummy-user PUBLIC ${CMAKE_BINARY_DIR})
add_coverage(dummy-user)
