cmake_minimum_required(VERSION 3.10)

project(TestingsTest
        VERSION "1"
        DESCRIPTION "Testings Test"
        HOMEPAGE_URL "https://github.com/flagarde/CMakeCM/blob/master/modules/Testings.cmake"
        LANGUAGES NONE
       )

set(CMAKE_MODULE_PATH "${MODULES_PATH}")

include(Testings)

ASSERT_EQUAL("1" "0")

ASSERT_NOT_EQUAL("0" "0")

ASSERT_NOT_EMPTY(${EMPTY})

set(NOT_EMPTY "NOT_EMPTY")
ASSERT_EMPTY(${NOT_EMPTY})

ASSERT_FILE_NOT_EXISTS("${MODULES_PATH}/Testings.cmake")

ASSERT_FILE_EXISTS("")
