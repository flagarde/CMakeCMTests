cmake_minimum_required(VERSION 3.10)

project(PingTest
        VERSION "1"
        DESCRIPTION "Ping Test"
        HOMEPAGE_URL "https://github.com/flagarde/CMakeCM/blob/master/modules/Ping.cmake"
        LANGUAGES NONE
       )

set(CMAKE_MODULE_PATH "${MODULES_PATH}")

include(Testings)
include(Ping)

if(NOT $ENV{CI} STREQUAL "") #If i'm running CI then I should be online.
  ASSERT_NOT_EQUAL("${IS_ONLINE}" "TRUE")
  ASSERT_NOT_EQUAL("${IS_OFFLINE}" "FALSE")
endif()
