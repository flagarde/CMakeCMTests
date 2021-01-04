cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
project(FindTests)

set(CMAKE_CXX_STANDARD "11")

# Determine which filesystem tests we should run based on the compiler version
set(tests Experimental Final MaybeFail)

foreach(test IN LISTS tests)
    add_subdirectory(${test})
endforeach()
