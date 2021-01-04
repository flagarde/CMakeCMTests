cmake_minimum_required(VERSION 3.5)
project(Test)

set(CMAKE_CXX_STANDARD "11")

include(../../CMakeCM.cmake)

include(CMakeRC)

cmrc_add_resource_library(dummy CMakeLists.txt)

add_executable(dummy-user main.cpp)
target_link_libraries(dummy-user PRIVATE dummy)
